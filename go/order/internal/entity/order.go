package entity

import "errors"

type Order struct {
	ID         string
	Price      float64
	Tax        float64
	FinalPrice float64
}

func (o *Order) CalculateFinalPrice() {
	o.FinalPrice = o.Price + o.Tax
}

func Neworder(id string, price float64, tax float64, finalPrice float64) (*Order, error) {
	order := &Order{
		ID:         id,
		Price:      price,
		Tax:        tax,
		FinalPrice: finalPrice,
	}
	err := order.Validate()
	if err != nil {
		return nil, err
	}
	return order, nil
}

func (o *Order) Validate() error {
	if o.ID == "" {
		return errors.New("id cannot be empty")
	}
	if o.Price <= 0 {
		return errors.New("price cannot be negative")
	}
	if o.Tax <= 0 {
		return errors.New("tax cannot be negative")
	}

}


func main() {
	return nil
}
