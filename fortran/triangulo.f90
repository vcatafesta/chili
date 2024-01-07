program DesenhaTriangulo
    implicit none
    integer :: altura, i, j

    altura = 20

    do i = 1, altura
        ! Espaços à esquerda
        do j = 1, altura - i
            write(*, '(A)', advance='no') ' '
        end do

        ! Caracteres no centro
        do j = 1, 2 * i - 1
            write(*, '(A)', advance='no') '#'
        end do

        ! Nova linha após cada linha do triângulo
        write(*, '(A)') ''
    end do

end program DesenhaTriangulo
