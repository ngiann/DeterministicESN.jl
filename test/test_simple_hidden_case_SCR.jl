#**********************************************
function test_simple_hidden_case_SCR()
#**********************************************

    # compare instantiated scr to hand computed scr

    net = SCR(N=5)
    setesn!(net, w = 0.1, v = 0.9, b = 0.5, α=0.2)

    hand_calculated_metrix = [0.0 0.0 0.0 0.0 0.1;
                              0.1 0.0 0.0 0.0 0.0;
                              0.0 0.1 0.0 0.0 0.0;
                              0.0 0.0 0.1 0.0 0.0;
                              0.0 0.0 0.0 0.1 0.0]

    all( hand_calculated_metrix .== net.Wrec )

end
