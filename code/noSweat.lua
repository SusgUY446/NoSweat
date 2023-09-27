game.Players.PlayerAdded:Connect(function(plr)
    
    plr.CharacterAdded:Connect(function(char)
        
        local hrp = char:WaitForChild("HumanoidRootPart")
        hrp:GetPropertyChangedSignal("CFrame"):Wait()
        
        local lastCF = hrp.CFrame
        local lastGroundedCF = hrp.CFrame
        local lastGrounded = tick()
        
        
        game:GetService("RunService").Heartbeat:Connect(function(step)
            
            local cf = hrp.CFrame
            
            --Walk Speed Cheats
            local velocityNoY = (cf.Position * Vector3.new(1, 0, 1) - lastCF.Position * Vector3.new(1, 0, 1)).Magnitude / step
            
            if velocityNoY > 50 then
                
                hrp.CFrame = lastCF
            end
            
            --Jump and Fly Cheats
            local raycastParams = RaycastParams.new()
            raycastParams.FilterDescendantsInstances = {plr.Character}
            
            local ray = workspace:Raycast(cf.Position, -cf.UpVector * 5, raycastParams)
            
            local velocityOnlyY = (cf.Position.Y - lastCF.Position.Y) / step
            
            if ray and ray.Instance.CanCollide then
                
                lastGrounded = tick()
                lastGroundedCF = hrp.CFrame
                
            elseif tick() - lastGrounded > 1 and velocityOnlyY >= 0 then
                
                hrp.CFrame = lastGroundedCF
            end
            
            --No Clip Cheats
            local raycastParams = RaycastParams.new()
            raycastParams.FilterDescendantsInstances = {plr.Character}
 
            local ray = workspace:Raycast(cf.Position, cf.LookVector * 1.5, raycastParams)
            
            if ray and ray.Instance.CanCollide then
                
                hrp.CFrame = lastCF
            end
            
            
            lastCF = hrp.CFrame
        end)
    end)
end)
