Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3AC3AB9CF
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Jun 2021 18:35:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G5SNK2yCwz3bsw
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Jun 2021 02:35:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=fdc-k.co.ke header.i=@fdc-k.co.ke header.a=rsa-sha256 header.s=s1 header.b=Ygu/4r9z;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=em4937.fdc-k.co.ke (client-ip=50.31.63.79;
 helo=o50316379.outbound-mail.sendgrid.net;
 envelope-from=bounces+17430347-3d43-linux-erofs=lists.ozlabs.org@em4937.fdc-k.co.ke;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=fdc-k.co.ke header.i=@fdc-k.co.ke header.a=rsa-sha256
 header.s=s1 header.b=Ygu/4r9z; dkim-atps=neutral
X-Greylist: delayed 65 seconds by postgrey-1.36 at boromir;
 Fri, 18 Jun 2021 02:35:39 AEST
Received: from o50316379.outbound-mail.sendgrid.net
 (o50316379.outbound-mail.sendgrid.net [50.31.63.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G5SNC1fkRz2xYp
 for <linux-erofs@lists.ozlabs.org>; Fri, 18 Jun 2021 02:35:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fdc-k.co.ke; 
 h=content-transfer-encoding:content-type:from:mime-version:to:subject:list-unsubscribe;
 s=s1; bh=1EHw0HAKMkkURiuK7ZWzNhyryTvO6x3wBuMIenMFLUI=; b=Ygu/4r9
 zOMV/y+LvtBlDzeeqicN9bTIKmrrWOVtVCnwwoOBMrQq7Wn/jKFRvkqQlbEJygh/
 AcDso3+2cWSs94BoTHAa8EHYlOuvktH56LPyHgNP4QymOwox+uBzOtxYUugb66ax
 VupLh6rFLfbLvDVmLFgRvk/CvydV3Dgfe4ow=
Received: by filter2362p1mdw1.sendgrid.net with SMTP id
 filter2362p1mdw1-8261-60CB5FFC-1A
 2021-06-17 14:45:16.810326635 +0000 UTC m=+2536806.633614786
Received: from MTc0MzAzNDc (unknown)
 by geopod-ismtpd-5-0 (SG) with HTTP id 6XoXI4nwQFOyzQHRSAtPnQ
 Thu, 17 Jun 2021 14:45:16.434 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8
Date: Thu, 17 Jun 2021 14:46:42 +0000 (UTC)
From: "Jackson From FDC-K Africa" <Jackson@fdc-k.co.ke>
Mime-Version: 1.0
To: linux-erofs@lists.ozlabs.org
Message-ID: <6XoXI4nwQFOyzQHRSAtPnQ@geopod-ismtpd-5-0>
Subject: Invitation to Project Monitoring and Evaluation with Data Management
 and Analysis July 2021 Workshop
X-SG-EID: D/WhaQyL81n52MRUxySh/FGW0Tvj3TKiZPeU+9+BRFY7Jqkobw7z2I3ffRnFhUIrRYMw8C37AdQlip
 fTxMB4GD+PMpsDq1imDH3IIbA5zX2BbY7oANVNPlwoxvxaYf4jjr+7a92/l/MOiQaJvZzP4qYl7wA6
 FwHRmBkdTzTG/xpviXFP2EVpYAe57EOOVBZVeAjBNWE5kJVTOPoUMZZdcSDU378fq7y/YAq4PEdrs8
 oH7QI8qjkCIJziXdIOKWV6
X-Entity-ID: lgZohGoWIjvYsKzlUpYsxA==
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

<!DOCTYPE html><html xmlns=3D"http://www.w3.org/1999/xhtml" style=3D"" clas=
s=3D" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation=
 postmessage websqldatabase indexeddb hashchange history draganddrop websoc=
kets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshado=
w textshadow opacity cssanimations csscolumns cssgradients cssreflections c=
sstransforms csstransforms3d csstransitions fontface generatedcontent video=
 audio localstorage sessionstorage webworkers no-applicationcache svg inlin=
esvg smil svgclippaths js csstransforms csstransforms3d csstransitions resp=
onsejs "><head>
        <title>Invitation to Project Monitoring and Evaluation with Data Ma=
nagement and Analysis   July 2021 Workshop</title>
        <meta name=3D"viewport" content=3D"width=3Ddevice-width, initial-sc=
ale=3D1.0" />
        <style type=3D"text/css" media=3D"only screen and (max-width: 480px=
)">
            /* Mobile styles */
            @media only screen and (max-width: 480px) {
                [class=3D"w320"] {
                    width: 320px !important;
                }
                [class=3D"mobile-block"] {
                    width: 100% !important;
                    display: block !important;
                }
            }
        </style>
                                      </head>
    <body style=3D"margin:0" class=3D"ui-sortable">
        <div data-section-wrapper=3D"1">
            <center>
                <table data-section=3D"1" style=3D"width: 600;" width=3D"60=
0" cellspacing=3D"0" cellpadding=3D"0">
                    <tbody>
                        <tr>
                            <td>
                                <div data-slot-container=3D"1" style=3D"min=
-height: 30px" class=3D"ui-sortable">
                                    <div data-slot=3D"text" data-param-padd=
ing-top=3D""><div data-empty=3D"true"><a href=3D""></a><img class=3D"fr-dib=
" src=3D"http://info.fdc-k.co.ke/media/images/cfa2339650bd7b95b8999b3698cf4=
02e.png" width=3D"792" height=3D"122" /></div><div data-empty=3D"true"><br =
/></div><div data-empty=3D"true"><a href=3D"http://url6478.fdc-k.co.ke/ls/c=
lick?upn=3DGLS-2FYQ6u7dEKmj0uSKpqemz299sgWAUYA-2F7kAumHSwITBjBJd20o-2BaoXoV=
2HfZMlEcP2p7WZC5aoXX43U-2BCQHb2x2tch9lnuj87CILsMiGphcabjaemzq8bFqY6ODaALfW4=
J2cb-2FVXwr6aoC3CiRy-2FYdha3WKqvd9y8w40At7W4T4nbCNFl8HAG17KCg0LWFzYYjGSlmYz=
FyRXueeBH04T9sn72gVsLYr-2FMJHBEA3rinP3PDjTOgz39jnKmKC4LRcLQVxyPQzDwWuLlkTqO=
6pPhVyZy1QLEfNMoj83pgH9iqqlmyxrsr7jqKxWrUnKbjDwkiL4k1r5dwyUhX3ESd9ZLLXY8QwK=
BBEcXAsh3BsyjR4jqkS3QdK7ocN1V68AMG22-2F9r81R-2BUD65BkDRHhZGgZIm9vItZVxcPUz1=
FOup-2B3KpaazP7JxItHjOrx65ApYzGacFAivVx6xX4hfcP36Gry-2Fu1E4qj2R8NXn-2B-2Btp=
v0U-3Dyov1_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEKYTQD8UoU0qdZeqM-2Bu24-2B1r=
D5bar1cSETAVA4Mp0KP3eQX4prU8Diah9poP-2FImccx-2BxXtkQ9CqE4N1Kt5wWc8605nEBQmj=
-2FEnmM1q9GivvQBgvunhPWX2iEegc45ieDW6iRG0K388DHdHOIKtk7CZak2zAI2RZIdimF9FvU=
cTQkiYO-2FLBAkMgD0-2BPE-2BKqdFHiZUeIw-3D" rel=3D"noopener noreferrer" targe=
t=3D"_blank"><img src=3D"http://info.fdc-k.co.ke/media/images/89d1877d2cb48=
ac765c13a5d881e1f15.jpeg" class=3D"fr-fic fr-dib" style=3D"width: 709px; he=
ight: 531.75px;" width=3D"709" height=3D"531.75" /></a></div><div data-empt=
y=3D"true"><a href=3D"http://url6478.fdc-k.co.ke/ls/click?upn=3DGLS-2FYQ6u7=
dEKmj0uSKpqemz299sgWAUYA-2F7kAumHSwI-2F7NdL9P9Y3CFgsBKOZ2b1-2BMNBJkN3aUArzl=
KA0V95l8qWgxdE-2FeRq6zN-2BnZ8MH9Hh3wuBUaw-2F9gAiOYDBRKFdsXqjucR1sJFv5Fpztzs=
XjjSXzefYzIL-2BNJzwVzd-2BkMAB1806KM7FQn68m7WD0nmi9RWxOEbNXMrkQhlAZt1Kg7Bhc9=
yfufEzLDK-2FlxfWF3D3A2XiLPFmQtj8jBq8FApdo8GKtvl6hfrWiYS2MXGBHZvEhOJKc-2Fo-2=
F5buWDdHdvU8g6JaKwCqslNNCg8TX1fL14vTdZAyGJ3rFgdBD4pupjpGe-2BWKHZ71PKKgxSj0u=
c4MgkPq-2Bnpv0bGZFwsfzzCUIKJPA6tjh4K4-2FHe1-2B8y50i5wRcWINb3hoYmd185pX4tSDV=
FiJD6Rdc-2FGEsvaTh1w36YwCjVIi0qLulL4H-2Fhaoou2GvPxpItv6TshxbGVt53c-3DHlPl_6=
pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEKYTQD8UoU0qdZeqM-2Bu24-2B1rD5bar1cSETAV=
A4Mp0KP3eQX4pnQcFQ-2FXCKkoP3o6sQ-2B6Uwav3ORorU9WNzIGtp2S05W5rXBW3TG-2FyrssB=
sHHeOQGoyTZph1iW5Aht1czRrwd-2ByjPh4inY58mKiVEJXohl6LmaInt9NV2YywKVDgwmSXLAL=
77qIQltVkGYZF0NW-2FCiyk-3D" rel=3D"noopener noreferrer" target=3D"_blank"><=
br /></a></div><a href=3D"http://url6478.fdc-k.co.ke/ls/click?upn=3DGLS-2FY=
Q6u7dEKmj0uSKpqemz299sgWAUYA-2F7kAumHSwITBjBJd20o-2BaoXoV2HfZMlEcP2p7WZC5ao=
XX43U-2BCQHb2x2tch9lnuj87CILsMiGphcabjaemzq8bFqY6ODaALfW4J2cb-2FVXwr6aoC3Ci=
Ry-2FYdha3WKqvd9y8w40At7W4T4nbCNFl8HAG17KCg0LWFzYYjGSlmYzFyRXueeBH04T9sn72g=
VsLYr-2FMJHBEA3rinP3PDjTOgz39jnKmKC4LRcLQVxyPQzDwWuLlkTqO6pPhVyZy1QLEfNMoj8=
3pgH9iqqlmyxrsr7jqKxWrUnKbjDwkiL4k1r5dwyUhX3ESd9ZLLXY8QwKBBEcXAsh3BsyjR4jqk=
S3QdK7ocN1V68AMG22-2F9r81R-2BUD65BkDRHhZGgZIm9vItZVxcPUz1FOup-2B3KpaazP7JxI=
tHjOrx65ApYzGacFAivVx6xX4hfcP36Gry-2Fu1E4qj2R8NXn-2B-2Btpv0U-3D33qK_6pwKHJ8=
Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEKYTQD8UoU0qdZeqM-2Bu24-2B1rD5bar1cSETAVA4Mp0K=
P3eQX4prclECHFoYMTFeToLjDY87c3LIUPxjqetZ2bn1-2BP3YLcH3AZistQVbMf4gL5SPq-2F-=
2F2TsZRJyMuha9j-2BDQiXqw5JYt5TGsWwNB7v9LmmkYuct6ePNCtVjX8LmEOLk3as3TV6pj2hn=
-2BX2pzbFIA9CRfhc-3D" rel=3D"noopener noreferrer" target=3D"_blank">Project=
 Monitoring and Evaluation with Data Management and Analysis Workshop July =
26 to August 06 2021 for 10 Days</a><table border=3D"0" cellpadding=3D"0" c=
ellspacing=3D"0" width=3D"0"><tbody><tr><td valign=3D"bottom" width=3D"1049=
"><div data-empty=3D"true"><br /></div></td></tr></tbody></table><table bor=
der=3D"0" cellpadding=3D"0" cellspacing=3D"0" width=3D"1049"><tbody><tr><td=
 valign=3D"bottom" width=3D"1049"><div data-empty=3D"true"><br /></div></td=
></tr></tbody></table><div data-empty=3D"true"><br /></div><a href=3D"http:=
//url6478.fdc-k.co.ke/ls/click?upn=3DGLS-2FYQ6u7dEKmj0uSKpqemz299sgWAUYA-2F=
7kAumHSwL1hBsN1Zn-2BK3NNqJuwj9OiVOpTWRHJPt0sSDNYCy2drqJvucUW85bG6BsA0MiTg7q=
DbPI7RTRUnhpDEKXhhZKlVRkTuH7olndogvZBNMc41lFTdZhvV7SXqfphWYF13HARVxjVFhevFK=
XcLnhJIS1KRrXSaNv24-2BCmymebV7OfdlFnP-2B82X-2BM1rQEKswk1-2FDmRGVGWYNNsF2Tnt=
-2FTw-2B3-2BbiHb3dHb1fVcRlYoAGY3FDrcTeBPrlvj9XcpMs4MJHhGCoyKGEDJgYPREkhU-2F=
Ys2EZGklz5kI1h7G3MF7Fp3mAxZoW02pqYZGGPetQ4H1PnpPdpFvVikRK33dpuF-2FfkFD1ck0m=
6lmlkwle-2FzGlgt8HEyBcEoxXAHD3i6EH0sJzJ81ih7jWr7IRyjIheOSDhPiL-2Fys2Cp2FVBv=
GTQFFOy-2Fz7E25piJ6nNWcecHZRnmAzI-3DLOT7_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJG=
dCEKYTQD8UoU0qdZeqM-2Bu24-2B1rD5bar1cSETAVA4Mp0KP3eQX4pqLpVxECH0iAkpQNgbSJ4=
OeAJMM1Gz19jSl8fERYLyw6yXnxzTxBd02AJWJPL8VofHNVKv-2FD1AB3R2TSMxeWlJ5zysdbdO=
UxCZE9K860-2BxtqvADqKLpa1K-2BG3aiTQOTF-2F4soD0i-2BuWl099ddfNkdthc-3D" rel=
=3D"noopener noreferrer" target=3D"_blank">Register for online attendance W=
orkshop</a><div data-empty=3D"true"><br /></div><a href=3D"http://url6478.f=
dc-k.co.ke/ls/click?upn=3DGLS-2FYQ6u7dEKmj0uSKpqemz299sgWAUYA-2F7kAumHSwITB=
jBJd20o-2BaoXoV2HfZMlEcP2p7WZC5aoXX43U-2BCQHb2x2tch9lnuj87CILsMiGphcabjaemz=
q8bFqY6ODaALfW4J2cb-2FVXwr6aoC3CiRy-2FYdha3WKqvd9y8w40At7W4T4nbCNFl8HAG17KC=
g0LWFzYYjGSlmYzFyRXueeBH04T9sn72gVsLYr-2FMJHBEA3rinP3PDjTOgz39jnKmKC4LRcLQV=
xyPQzDwWuLlkTqO6pPhVyZy1QLEfNMoj83pgH9iqqlmyxrsr7jqKxWrUnKbjDwkiL4k1r5dwyUh=
X3ESd9ZLLXY8QwKBBEcXAsh3BsyjR4jqkS3QdK7ocN1V68AMG22-2F9r81R-2BUD65BkDRHhZGg=
ZIm9vItZVxcPUz1FOup-2B3KpaazP7JxItHjOrx65ApYzGacFAivVx6xX4hfcP36Gry-2Fu1E4q=
j2R8NXn-2B-2Btpv0U-3DheTB_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEKYTQD8UoU0qd=
ZeqM-2Bu24-2B1rD5bar1cSETAVA4Mp0KP3eQX4ph6fJpC8GwrAYmBmfvmmKKZrSHZN9KU7x3Rd=
5cCJ4ja8oLfMHb8CI-2BR33JoGVXmzyGy5xwP2BFQJQNkx-2FywfR4UEGTwZnzH94H9kiGxen2A=
J3aGLKuViwVZkFfFb41bZgeCuorhUox2n-2FDOif6X0vhs-3D" rel=3D"noopener noreferr=
er" target=3D"_blank">Register Normal attendance workshop</a><div data-empt=
y=3D"true"><br /></div><a href=3D"http://url6478.fdc-k.co.ke/ls/click?upn=
=3DGLS-2FYQ6u7dEKmj0uSKpqemz299sgWAUYA-2F7kAumHSwIrXRZPYYSNb6EdQCsmmOWbmge9=
oqXeEJgl2xCPQwR82T84gwoNBjCGWaggYHgVvaZtsePLI3Cp3luMpcJoJzedpVHEeavhEKSoCzK=
X7FnZ9o0BmpbVbwxE5aA2P3FnGEhWFKgNZj02axNKOZ5ys20lTIIu3h3-2BtecDTgj73pzsSMQ5=
gzyFtw4IJSn7RGbXjL-2FohQ8CotdNTDVStOPHHpxaEwK4goLLVIkI2rsbQpT0Axr-2BZMzsOoS=
Y08jFOj3UEVjJrtXBjkGifzHyzSG3TfDmOcqp1yYij2FeVf1LxDyojFrOlE1vmpcA95vMMVP-2F=
qM8zJ679tAZum6VFcjGxnTyNSfhEPcIVwCs9-2BOdZq9sSJ-2BGVL3spE8AA7kT6gHl6ZyB90Wd=
VbP7kC3nu5Bd3aTzesRSsX65eiiOFFjMIufxoO98eYTIkVGVBdIEGYyRuM9k-3DDyEp_6pwKHJ8=
Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEKYTQD8UoU0qdZeqM-2Bu24-2B1rD5bar1cSETAVA4Mp0K=
P3eQX4pu8iu6VaOpgvDG0Xl-2BCKbz4H07-2BW-2BLaeh-2B6eUzpudxZWOboES-2BeDxEk6mVn=
bCsf-2FXIqCWBRLyoqNac-2Ba-2FAbbcpMnPy6r-2BK-2BUlHOBRjICjbUGoUpMg2-2Fjf4VOPK=
1C8XTRjsCz9ZhmMlwSGQxDShvTTKU-3D" rel=3D"noopener noreferrer" target=3D"_bl=
ank">Download PDF Calendar 2021 Workshops</a><div data-empty=3D"true"><br /=
></div><a href=3D"http://url6478.fdc-k.co.ke/ls/click?upn=3DGLS-2FYQ6u7dEKm=
j0uSKpqemz299sgWAUYA-2F7kAumHSwJi6v9G1gJe-2BHpxYVAJlbllTQ0twEl0yiO3lpSqqiKd=
NT1NdyA3JmbBOcPE01wSUQzrFjkFjP5QyOXB79SYA1vevoR9hTxl4fwy3mJYQZh4dkDMAwMNqHS=
lYExWX2y4IWgZFu2Pq1us-2Fg2eKYtSU4G35ZqYjf8pI3Qg1-2BlzwFdDyt9TD30EbzmD93nNiK=
E4-2F3qT0mU3eECvEjv7UuyxwHnVwaheJ6VIHo6KksBLexXcYVJCLt1lntj79Ts2UX8jdZAgPXp=
s-2FOjIxMIXTLuOPRh4oEsXEYXp1ooTKAWkks8JsiQZ8lrKZy9Fott67JC8k8LAGo4-2F9sL6gz=
6xDr2bFA744l2GbpSFbF5YmKlthsz3UFfSWmilZA6iSkQQTt0StLCuOGu1fDla2XK-2BseXhM2s=
HTG-2Bn-2Bj0Gppdsw7VB1-2FkEKGJ808wWlBmP-2FFpQ-2BHalUEk-3DxBy2_6pwKHJ8Ph1XTy=
v7ONZlOBCAyk5EA9C6LJGdCEKYTQD8UoU0qdZeqM-2Bu24-2B1rD5bar1cSETAVA4Mp0KP3eQX4=
pngFBPRkNLb-2BIdd0AwCv7uRZF6aL2tSIXCdwUzkaxTLU7-2FsGVObSbvHr3RPnAVkA7old5cG=
E2K7GucK7mzI-2FBFBuYYhRmE2v-2B2rPhMXpIokOWsT0hNCclvGwpm-2B2jBR7tdS2dDqoB8nW=
cDYPHccIp-2Bg-3D" rel=3D"noopener noreferrer" target=3D"_blank">Get Registr=
ation Form</a><br /><br />VENUE: <strong>Nairobi Kenya Best Western Plus Me=
ridian Murang'a Road</strong><br /><br /><div data-empty=3D"true"><br /></d=
iv>OFFICIAL EMAIL ADDRESS: =C2=A0 =C2=A0 training@fdc-k.org<div data-empty=
=3D"true"><br /></div>Office Telephone: +254712260031<div data-empty=3D"tru=
e"><br /></div>Register as a group of 5 or more participants and get 20% di=
scount on course fee. Send us email to training@fdc-k.org or call +25471226=
0031<div data-empty=3D"true"><br /></div><strong>About the course</strong><=
br />This is a comprehensive 10 days M&amp;E course that covers the princip=
les and practices for results based monitoring and evaluation for the entir=
e project life cycle. This course equips participants with skills in settin=
g up and implementing results based monitoring and evaluation systems inclu=
ding M&amp;E data management, analysis and reporting. The participants will=
 benefit from the latest M&amp;E thinking and practices including the resul=
ts and participatory approaches. This course is designed to enable the part=
icipants become experts in monitoring and evaluating their development proj=
ects. The course covers all the key elements of a robust M&amp;E system cou=
pled with a practical project to illustrate the M&amp;E concepts.<br /><str=
ong>Target Participants</strong><br />This course is designed for researche=
rs, project staff, development practitioners, managers and decision makers =
who are responsible for project, program or organization-level M&amp;E. The=
 course aims to enhance the skills of professionals who need to research, s=
upervise, manage, plan, implement, monitor and evaluate development project=
s.<br /><strong>Course duration</strong><br />10 days<br /><strong>Course o=
bjectives</strong><br /><ul type=3D"disc"><li>Develop project results level=
s</li><li>Design a project using logical framework</li><li>Develop indicato=
rs and targets for each result level</li><li>Track performance indicators o=
ver the life of the project</li><li>Evaluation a project against the set re=
sults</li><li>Develop and implement M&amp;E systems</li><li>Develop a compr=
ehensive monitoring and evaluation plan</li><li>Use data analysis software =
(Stata/SPSS/R)</li><li>Collect data using mobile data collection tools</li>=
<li>Carryout impact evaluation</li><li>Use GIS to analyze and share project=
 data</li></ul><strong>Course Outline</strong><br /><strong>Introduction to=
 Results Based Project Management</strong><br /><ul type=3D"disc"><li>Funda=
mentals of Results Based Management</li><li>Why is RBM important?</li><li>R=
esults based management vs traditional projects management</li><li>RBM Life=
cycle (seven phases)</li><li>Areas of focus of RBM</li></ul><strong>Fundame=
ntals of Monitoring and Evaluation</strong><br /><ul type=3D"disc"><li>Defi=
nition of Monitoring and Evaluation</li><li>Why Monitoring and Evaluation i=
s important</li><li>Key principles and concepts in M&amp;E</li><li>M&amp;E =
in project lifecycle</li><li>Participatory M&amp;E</li></ul><strong>Project=
 Analysis</strong><br /><ul type=3D"disc"><li>Situation Analysis</li><li>Ne=
eds Assessment</li><li>Strategy Analysis</li></ul><strong>Design of Results=
 in Monitoring and Evaluation</strong>=C2=A0<br /><ul type=3D"disc"><li>Res=
ults chain approaches: Impact, outcomes, outputs and activities</li><li>Res=
ults framework</li><li>M&amp;E causal pathway</li><li>Principles of plannin=
g, monitoring and evaluating for results</li></ul><strong>M&amp;E Indicator=
s</strong><br /><ul type=3D"disc"><li>Indicators definition</li><li>Indicat=
or metrics</li><li>Linking indicators to results</li><li>Indicator matrix</=
li><li>Tracking of indicators</li></ul><strong>Logical Framework Approach</=
strong><br /><ul type=3D"disc"><li>LFA =E2=80=93 Analysis and Planning phas=
e</li><li>Design of logframe</li><li>Risk rating in logframe</li><li>Horizo=
ntal and vertical logic in logframe</li><li>Using logframe to create schedu=
les: Activity and Budget schedules</li><li>Using logframe as a project mana=
gement tool</li></ul><strong>Theory of Change</strong><br /><ul type=3D"dis=
c"><li>Overview of theory of change</li><li>Developing theory of change</li=
><li>Theory of Change vs Log Frame</li><li>Case study: Theory of change</li=
></ul><strong>M&amp;E Systems</strong><br /><ul type=3D"disc"><li>What is a=
n M&amp;E System?</li><li>Elements of M&amp;E System</li><li>Steps for deve=
loping Results based M&amp;E System</li></ul><strong>M&amp;E Planning</stro=
ng><br /><ul type=3D"disc"><li>Importance of an M&amp;E Plan</li><li>Docume=
nting M&amp;E System in the M&amp;E Plan</li><li>Components of an M&amp;E P=
lan-Monitoring, Evaluation, Data management, Reporting</li><li>Using M&amp;=
E Plan to implement M&amp;E in a Project</li><li>M&amp;E plan vs Performanc=
e Management Plan (PMP)</li></ul><strong>Base Survey in Results based M&amp=
;E</strong><br /><ul type=3D"disc"><li>Importance of baseline studies</li><=
li>Process of conducting baseline studies</li><li>Baseline study vs evaluat=
ion</li></ul><strong>Project Performance Evaluation</strong><br /><ul type=
=3D"disc"><li>Process and progress evaluations</li><li>Evaluation research =
design</li><li>Evaluation questions</li><li>Evaluation report Dissemination=
</li></ul><strong>M&amp;E Data Management</strong>=C2=A0<br /><ul type=3D"d=
isc"><li>Different sources of M&amp;E data</li><li>Qualitative data collect=
ion methods</li><li>Quantitative data collection methods</li><li>Participat=
ory methods of data collection</li><li>Data Quality Assessment</li></ul><st=
rong>M&amp;E Results Use and Dissemination</strong><br /><ul type=3D"disc">=
<li>Stakeholder=E2=80=99s information needs</li><li>Use of M&amp;E results =
to improve and strengthen projects</li><li>Use of M&amp;E Lessons learnt an=
d Best Practices</li><li>Organization knowledge champions</li><li>M&amp;E r=
eporting format</li><li>M&amp;E results communication strategies</li></ul><=
strong>Gender Perspective in M&amp;E</strong><br /><ul type=3D"disc"><li>Im=
portance of gender in M&amp;E</li><li>Integrating gender into program logic=
</li><li>Setting gender sensitive indicators</li><li>Collecting gender disa=
ggregated data</li><li>Analyzing M&amp;E data from a gender perspective</li=
><li>Appraisal of projects from a gender perspective</li></ul><strong>Data =
Collection Tools and Techniques</strong><br /><ul type=3D"disc"><li>Sources=
 of M&amp;E data =E2=80=93primary and secondary</li><li>Sampling during dat=
a collection</li><li>Qualitative data collection methods</li><li>Quantitati=
ve data collection methods</li><li>Participatory data collection methods</l=
i><li>Introduction to data triangulation</li></ul><strong>Data Quality</str=
ong>=C2=A0<br /><ul type=3D"disc"><li>What is data quality?</li><li>Why dat=
a quality?</li><li>Data quality standards</li><li>Data flow and data qualit=
y</li><li>Data Quality Assessments</li><li>M&amp;E system design for data q=
uality</li></ul><strong>ICT in Monitoring and Evaluation</strong><br /><ul =
type=3D"disc"><li>Mobile based data collection using ODK</li><li>Data visua=
lization - info graphics and dashboards</li><li>Use of ICT tools for Real-t=
ime monitoring and evaluation</li></ul><strong>Qualitative Data Analysis</s=
trong><br /><ul type=3D"disc"><li>Principles of qualitative data analysis</=
li><li>Data preparation for qualitative analysis</li><li>Linking and integr=
ating multiple data sets in different forms</li><li>Thematic analysis for q=
ualitative data</li><li>Content analysis for qualitative data</li><li>Manip=
ulation and analysis of data using NVivo</li></ul><strong>Quantitative Data=
 Analysis =E2=80=93 (Using SPSS/Stata)</strong><br /><ul type=3D"disc"><li>=
Introduction to statistical concepts</li><li>Creating variables and data en=
try</li><li>Data reconstruction</li><li>Variables manipulation</li><li>Desc=
riptive statistics</li><li>Understanding data weighting</li><li>Inferential=
 statistics: hypothesis testing, T-test, ANOVA, regression analysis</li></u=
l><strong>Impact Assessment</strong><br /><ul type=3D"disc"><li>Introductio=
n to impact evaluation</li><li>Attribution in impact evaluation</li><li>Est=
imation of counterfactual</li><li>Impact evaluation methods: Double differe=
nce, Propensity score matching</li></ul><strong>GIS in M&amp;E</strong><br =
/><ul type=3D"disc"><li>Introduction to GIS in M&amp;E</li><li>GIS analysis=
 and mapping techniques</li><li>Data preparation for geospatial analysis</l=
i><li>Geospatial analysis using GIS software (QGIS)</li></ul><br /><div dat=
a-empty=3D"true"><br /></div><div data-empty=3D"true"><strong>General Notes=
</strong><ul><li>All our courses can be Tailor-made to participants needs</=
li><li>The participant must be conversant with English</li><li>Presentation=
s are well guided, practical exercise, web based tutorials and group work. =
Our facilitators are expert with more than 10years of experience.</li><li>U=
pon completion of training the participant will be issued with Foscore deve=
lopment center certificate (FDC-K)</li><li>Training will be done at Foscore=
 development center (FDC-K) center in Nairobi Kenya. We also offer more tha=
n five participants training at requested location within Kenya, more than =
ten participant within east Africa and more than twenty participant all ove=
r the world.</li><li>Course duration is flexible and the contents can be mo=
dified to fit any number of days.</li><li>The course fee includes facilitat=
ion training materials, 2 coffee breaks, buffet lunch and a Certificate of =
successful completion of Training. Participants will be responsible for the=
ir own travel expenses and arrangements, airport transfers, visa applicatio=
n dinners, health/accident insurance and other personal expenses.</li><li>A=
ccommodation, pickup, freight booking and Visa processing arrangement, are =
done on request, at discounted prices.</li><li>One year free Consultation a=
nd Coaching provided after the course.</li><li>Register as a group of more =
than two and enjoy discount of (10% to 50%) plus free five hour adventure d=
rive to the National game park.</li><li>Payment should be done two week bef=
ore commence of the training, to FOSCORE DEVELOPMENT CENTER account, so as =
to enable us prepare better for you.</li><li>For any enquiry to:training@fd=
c-k.org or +254712260031</li></ul><strong>OTHER UPCOMING WORKSHOPS FOR =C2=
=A0JULY 2021 ( CLICK LINK TO REGISTER FOR THE WORKSHOP AS INDIVIDUAL OR GRO=
UP)</strong><div data-empty=3D"true"><br /></div><table border=3D"0" cellpa=
dding=3D"0" cellspacing=3D"0" style=3D"margin-right: calc(19%); width: 81%;=
" width=3D"0"><tbody><tr><td valign=3D"bottom" width=3D"708"><ul><li><a hre=
f=3D"http://url6478.fdc-k.co.ke/ls/click?upn=3DGLS-2FYQ6u7dEKmj0uSKpqemz299=
sgWAUYA-2F7kAumHSwJTln5mvo5OyeHnPsNyYwe7yQXipQlHmw2pwL1qmxgeJ4FDoF-2BKntVV6=
JW2IXHh4Nx5aCny-2BjP3irg1cqSa7aS79bXx5aT-2FsH6tY-2BwGeT-2F-2BI0jRRS9YO54Zct=
LpFpKu3Y43ZpU8mDeKcEeGvOaKSBK3vAxCy3zGH5595b0xwXoy0Be-2FJcSsHYm32Hw0m9eXuT4=
Jg391muDFmg6emNItcEIhGVMbamV8Wu75ZTFbg9OH2AhyyOXxjBTry-2FENal5A-2Bc0-2F9XP7=
Q757aIlHTfLMarhVIHcszVyUoVCmKuF-2B7-2BshSJYhgAk-2BWz63kzpxnPDJVqlKhnbLVtbq4=
Ip9Hvt66QzwPEB60ochacLHKNOuQgAx9mbFDF1ZK-2BST2Ib3c1QOpvZTsN9xDeB006AgR8ajRz=
sKWvgVyh7LRlwuxkon5Xq0zVKM5L9t0vDWrH1Z63sTDeE-3DOO0W_6pwKHJ8Ph1XTyv7ONZlOBC=
Ayk5EA9C6LJGdCEKYTQD8UoU0qdZeqM-2Bu24-2B1rD5bar1cSETAVA4Mp0KP3eQX4phNLTMzVx=
WnqhdxNb9iDV-2FR8wSjrlhNpLeO-2FaiArEF-2FaF-2BUPSV9NzfzfnOj-2BOd-2FOuigJeoUG=
ORQqYreqdxUTJ9c7Obh3FEK-2BuWthVJ9XRGIFZ-2BkIqxi2f7PQxMoKmt6CqcABjrbgqHAJR-2=
FvKlEa5OMY-3D" rel=3D"noopener noreferrer" target=3D"_blank">Mobile Data Co=
llection using ODK &amp; KoboToolBox for Monitoring and Evaluation Workshop=
-July 05 to July 09,2021 for 10 Days</a></li></ul><div data-empty=3D"true">=
<br /></div><ul><li><div data-empty=3D"true"><a href=3D"http://url6478.fdc-=
k.co.ke/ls/click?upn=3DGLS-2FYQ6u7dEKmj0uSKpqemz299sgWAUYA-2F7kAumHSwJR3aUo=
t0HMqmclsdiEVes-2FAFPDYMvIExe5Y9ephCe2-2FFA7sKdAaldJS-2Bw6rJAg-2BllK2TfrN-2=
BC1qAXfQB5H6POypxiR-2Fjv-2BdtAmJ04vazFkpBoLLhouGzu-2F0Z9rm-2BiXO-2FITOrLHvY=
fskCG890WSmOtXdZP3Lzv1IPSkaZrca9KbIyqFC8qCFxx6zjVqO8M90mDVsxDIB3Pt-2F80Dd93=
ZsmgoHzE1bIdZEAIlCGPbA16uAMmx2dZLOz4etdYWV227EJB8zs7uosWaCqvr6XMpbo-2BNQ67M=
pf-2BzLvUayDiTdrdd0CLP8-2BYKSCWNAN7hMIr6cJYsMWx5jfgkxK0QcQldAgo7Y8JWSxUTq-2=
BvVSvwDITvd1HMmaKhLyzygCctgtqh-2FiXctViCzLzv-2F1q9tFkJ2W-2BawCNn-2F0y9l1kOK=
Z1CvBjrsJc4aferZjXXXyn1NkTjEvK0-3DKxE4_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdC=
EKYTQD8UoU0qdZeqM-2Bu24-2B1rD5bar1cSETAVA4Mp0KP3eQX4prqgNLbwtCjFnXu3c0KDfbS=
RYd4itWhHnoZ4yU8Dojniwa48I6uhgXwCP8QJMxeFffRHStQ4RgCZip7541kgHIb5lE7RSOZX7O=
99ytpUeZVRp7Aj5Kj6dKl78VbVrN3JiXusc9IU6xWgkvHpvIjWXgI-3D" rel=3D"noopener n=
oreferrer" target=3D"_blank">Quantitative Data Management and Analysis with=
 STATA Workshop from July 05 2021 for 5 Days</a></div></li></ul><div data-e=
mpty=3D"true"><br /></div><ul><li><a href=3D"http://url6478.fdc-k.co.ke/ls/=
click?upn=3DGLS-2FYQ6u7dEKmj0uSKpqemz299sgWAUYA-2F7kAumHSwLQUw3TqS7PYrPVtix=
z4NVCHt9OchFm8rWz9LnYGLUouFQkNmQavJEBhlOPIA3-2Bb8lrUn-2BDZTvMjcHCybT-2BXTdo=
1a-2FWDw-2BhVaHdJoQCwV0kJBVyO1BIF4wfLtWmJd5WDzPX8O9JWLnTdSL0dOBp9EEW35GNK2R=
AklCXHocypsCIaSMjUe4XFhFm-2Bm210qWZlvHaJOQQHkUCKirR-2BT2INgJsNOnIgNqA5JesoW=
96s3FhSk2HElbGZR8v2dtDsqWVWFdcGIByw6tmowV7tMQ4cHXbMh4XJAfYDyOGi23SMl6qumze3=
H9wh2u-2BEPistDepiJmRN-2FrZ-2B5A50EvchXMr3fOxJntXzI2HYh2OaAG1YRWWUrWYvw4u-2=
Fwb3cR1lQzlvlJ1O57A5x9Ct0z4YJ6WHjJSImmfdAk1rnS54CYuzoYETlinvOKY82ukqzSY51jV=
6xnU-3D6O58_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEKYTQD8UoU0qdZeqM-2Bu24-2B1=
rD5bar1cSETAVA4Mp0KP3eQX4po-2Bkoq2793EM2cpOrMV9y44E-2BWxRm0B4CEo4-2Bxe0JZCO=
COsCjkPQwdvylAI8Pb2i59sjrb1R7k2XwFo0e6-2Bu94zNXw6eW4E4FLv4l4MjibjGfKnC6JIBG=
-2B7nOutfrYGf1SJCh6-2BLvTkvF-2FvumhndL-2Fw-3D" rel=3D"noopener noreferrer" =
target=3D"_blank">Introduction to GIS using ArcGIS Workshop from July 05 20=
21 for 5 Days</a></li></ul><div data-empty=3D"true"><br /></div><ul><li><a =
href=3D"http://url6478.fdc-k.co.ke/ls/click?upn=3DGLS-2FYQ6u7dEKmj0uSKpqemz=
299sgWAUYA-2F7kAumHSwJ4OY4WbS53DoVU3LitTau4elAhAYSEVBHVhwDeL6BBqdM2fHSuj-2B=
5qZw1Kc6nHX6trob-2Fl3xew2klvkvs0qZnrD6z0S8bYC9zy-2BSk17xVbu3KJTHqSbdgZ9ZyDm=
YyWvEt7eBgrgZnHF05BQ5WYfdYrgQMA01lN07-2Foitsy3Mj-2BY1mBdyQlca3JiJa3f6k5hqPi=
2WmJLiEEp0jJ9rQSURMkX1yXXeBiJ0GmkfEAhLGxJCFIw30zLsYbWPyGc2LSLs3PSo5Yh08-2BM=
9Nc5g0B-2FMXBwq1mvid6Fs3Wl-2BpyV4AaXQuQGzMgoayRXjv-2FKxfNUuke9AiMlM7LB9HX7S=
hva9A-2FECCn8Gx0VigCtiloVIPGpNNaqkI12jqEb6xj4pMVS-2BOJyp8QADMOel7c1LiBSsbFq=
YnesMBhN-2BpeNhlML4u81Uw5vjMnVSGhlxc54-2F8hAxE-3DdCU4_6pwKHJ8Ph1XTyv7ONZlOB=
CAyk5EA9C6LJGdCEKYTQD8UoU0qdZeqM-2Bu24-2B1rD5bar1cSETAVA4Mp0KP3eQX4ppdGWBEv=
tsW5IGrA1frdGfrQehUzp-2F4Yk6zgWZbZenK9PQ3zlPgXcw0mLp9frPF-2Bim0KlqhTn71dxOp=
KkE4Z3IlMvbmY3KL6YOcvicd2lLEVaTkXW5snyzZQH8L3UOWZ9nvu0MGBvPoekJ11a1EJxL0-3D=
" rel=3D"noopener noreferrer" target=3D"_blank">Monitoring and Evaluation f=
or Food Security and Nutrition Workshop from July 12 2021 for 10 Days</a></=
li></ul><div data-empty=3D"true"><br /></div><ul><li><a href=3D"http://url6=
478.fdc-k.co.ke/ls/click?upn=3DGLS-2FYQ6u7dEKmj0uSKpqemz299sgWAUYA-2F7kAumH=
SwIfxwOFytf-2B31P13-2B4o4qGEuA89Tt3GpE5j79vd4wTBXTApee-2BPGQmnox6lRUdbBBudC=
q1a4GPiwOpAnNfehLiywk6iXmtcZGc4CAstl-2BKUKaKVdVBmQDw622p4WPehny7mmwZtSf36Cs=
pDlpc8yeb6Sp2XoDxtaKlEowv7SpxXGZAN39OCIjGH6yWhm2596xfcUa8I-2FvrgirXHLxJJepz=
BAPOdlZrCzP55maUahUuUIGF0q6nrqKP535epFUzB-2FS5SvZTuMCmVXSgE6IHTrRCsyJsIQREX=
O-2FAFqN4-2Fv-2B259JiCpldZiO2M8JBo99adab9m6bQRqqeL8eRXHxGpQAyP44rqnK4PLtdtp=
AzH7SzBqVoTxv6doNeL7ouqD3sv3hhU04YWoMZSJ2Ijsttkyu2V9VB55i4jJ4AeGIWKOu2Uj7zj=
49TeQR9udNh3kLCPS0s-3DOz6N_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEKYTQD8UoU0q=
dZeqM-2Bu24-2B1rD5bar1cSETAVA4Mp0KP3eQX4pjeu9T9Xl-2BF2Fqu4WMlx6CjX-2FCrFvDa=
PxOinSV6r3qXODRfljaIEaKwQ8OEr1oLC-2FshkTTmqP-2BiSuCp-2F7-2FJVoG92CbbyxQhk2E=
CfMPEbOCpC70zI3MVM8SBdpm-2BoO0EB6v5b9TaPkpDybrHBlucW3Dc-3D" rel=3D"noopener=
 noreferrer" target=3D"_blank">GIS and Data Analysis for WASH (Water Sanita=
tion and Hygiene) Programmes Workshop July 12 2021 for 10 Days</a></li></ul=
><div data-empty=3D"true"><br /></div><ul><li><a href=3D"http://url6478.fdc=
-k.co.ke/ls/click?upn=3DGLS-2FYQ6u7dEKmj0uSKpqemz299sgWAUYA-2F7kAumHSwKcFfL=
q4nVwWUAvAzDbfhXfiiEMQf8LA79UriIcpm4W57PYMYMtnkenehpx64C7cpHOFcITOlBSXhju7K=
zYsH-2FJMCyUFDLS4b5wbqDGTwMpq-2FeRWId6gQ99HSOohciy4tgZ3R16PDVsIKV5yitU1OGpC=
TK1LCDSSAq5ID1giifdLltwBX3h0nc1WCgnuuGqoEBQBTQuzLTngfb-2BTji13AN5B6cdC3qx8t=
Ih-2BO-2FXa3GvH7-2FpOjXe-2BSnSlf4P9pPAyqa4eke6N-2BqOnHl0vKBtT1juo1S69vXMATG=
8egCtXTFpKvt-2B2pKydTInUEICVxfPBBZbysTTFMcALSF2NKfqesOXEUbHeOTGIuqOHYC0MNWw=
cvUgm5-2BNGd-2Bdc2z6vSQX61Exgb1V1f0dhbe7G-2FCdSUVEe9QwiUIsgCec0LIqxq41ouqWL=
WaURt0EObvbWJxWk4c-3DurA6_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEKYTQD8UoU0qd=
ZeqM-2Bu24-2B1rD5bar1cSETAVA4Mp0KP3eQX4ps94lpD7yAFd12Hp7CcFbqEgPyl9TB-2BLIS=
j-2BR-2BQocW40S2bEKLDyNstFgaooOCUfDjlTL7LTulOvHM4VgmAZEEas0bdfo2yQe38sIAzWh=
4Id6AtLmiQworO8txWVC-2FipkDukuYPM6Qud-2BTeubQnDVKw-3D" rel=3D"noopener nore=
ferrer" target=3D"_blank">Grant Management and Fundraising =C2=A0Workshop J=
uly 12 2021 for 5 Days</a></li></ul><div data-empty=3D"true"><br /></div><u=
l><li><a href=3D"http://url6478.fdc-k.co.ke/ls/click?upn=3DGLS-2FYQ6u7dEKmj=
0uSKpqemz299sgWAUYA-2F7kAumHSwJ4OY4WbS53DoVU3LitTau4elAhAYSEVBHVhwDeL6BBqdM=
2fHSuj-2B5qZw1Kc6nHX6trob-2Fl3xew2klvkvs0qZnrD6z0S8bYC9zy-2BSk17xVbu3KJTHqS=
bdgZ9ZyDmYyWvEt7eBgrgZnHF05BQ5WYfdYrgQMA01lN07-2Foitsy3Mj-2BY1mBdyQlca3JiJa=
3f6k5hqPi2WmJLiEEp0jJ9rQSURMkX1yXXeBiJ0GmkfEAhLGxJCFIw30zLsYbWPyGc2LSLs3PSo=
5Yh08-2BM9Nc5g0B-2FMXBwq1mvid6Fs3Wl-2BpyV4AaXQuQGzMgoayRXjv-2FKxfNUuke9AiMl=
M7LB9HX7Shva9A-2FECCn8Gx0VigCtiloVIPGpNNaqkI12jqEb6xj4pMVS-2BOJyp8QADMOel7c=
1LiBSsbFqYnesMBhN-2BpeNhlML4u81Uw5vjMnVSGhlxc54-2F8hAxE-3DIVw6_6pwKHJ8Ph1XT=
yv7ONZlOBCAyk5EA9C6LJGdCEKYTQD8UoU0qdZeqM-2Bu24-2B1rD5bar1cSETAVA4Mp0KP3eQX=
4pp9ZxJTqpWZQjLprn58sUioo7vlolzfH7ylGNGRuORnrWouXPlDQ-2F81QiK3MRYavF7CZJQXI=
Gbu9Yd2iV3nAxhwc-2FPcTcYFCRB2agVUJkpa1mR4JZRjfy-2FuQezmOYG7oyHVArdR3aU3ujWZ=
onKep8jI-3D" rel=3D"noopener noreferrer" target=3D"_blank">Flood Disaster R=
isk Management in a Changing Climate Workshop July 12 2021 for 10 Days</a><=
/li></ul><div data-empty=3D"true"><br /></div><ul><li><a href=3D"http://url=
6478.fdc-k.co.ke/ls/click?upn=3DGLS-2FYQ6u7dEKmj0uSKpqemz299sgWAUYA-2F7kAum=
HSwL65hTI68p0tNmQocFzANQzpApLzAS5C-2FCWnDH23qZGpffEZRPZk5FM97u2-2BFtvO5NO9t=
FNht49NDycYOf109cXnv9yL1z6xNJ7EdCLiupj3DNOB62MbKd7hsylmPkAIkEh9MNS4EJjsXFKt=
MJL6GGEaPXP3uYzbcpHnNW4-2FQM99WznjwS1mmfzKCiTLAOcXLZHXhzzZIRJBQKq1FTjsTEAjy=
UcErwwUidUVcKrVewZ-2F0eyb0XHRPXALTUnU-2BPW9JMQXJp7Eu1JL6VqoOYNLWrN3lIqE4XDD=
MGiHfktB8iO5E5yYonKc4FwaGBTeiqhg0UQ159lg4BSN9PTf0u4BdpqRTuJFBdObHD1JAbwoMkP=
DpU9uhL2LcPoS2Yz2SRsSeYHpD7GJ2adaceLuImYzljQbBCbWFxggi-2FKxiWJ2IQzJID-2FaX-=
2BPgiUYkgzrz92UxEo-3DneRF_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEKYTQD8UoU0qd=
ZeqM-2Bu24-2B1rD5bar1cSETAVA4Mp0KP3eQX4pu6WiB9TFnZBLwnAgNubot7C-2F1iDxx29S6=
YBHBdHD-2FT1Uq6VyWzSCptvFXCNQaodmcii82-2FiXxxLeO7VdSG9lcUrdaxzdS2-2FjPobuGA=
3gVq04GlassrAI4S4NyjK76-2BK-2BAx-2B1nNsslZtmMwi0j0-2Bt78-3D" rel=3D"noopene=
r noreferrer" target=3D"_blank">Advanced Monitoring and Evaluation for Deve=
lopment Workshop July 19 2021 for 10 Days</a></li></ul><div data-empty=3D"t=
rue"><br /></div><ul><li><a href=3D"http://url6478.fdc-k.co.ke/ls/click?upn=
=3DGLS-2FYQ6u7dEKmj0uSKpqemz299sgWAUYA-2F7kAumHSwK2sp2U-2B4hIr1FGLKjmrAfSaf=
o8v2lFpvqXOld7qxvxVIEB-2FIKg8TKH287BMipJjz66tXnBzTpshI-2B68I-2BLyzV70MFiKkm=
ShM-2BHliP-2BfbwQnZCfUM3nWOQLz8qWchT-2BT0UmiKATYFLKELPQOTVnZqc8WCMLzOjIFifH=
HIUALkvWnIS2Ph3igUN-2B-2FeHCX4XRlxEKpZqUaWthQNEVJ63mHAr1CROVy6-2Ffipr3eQ22c=
FAM1nZpoKCq5kPgCpRWo4Lm9kJd96L8C1-2FTIKfXoz-2FoWHhPkqOOtoEUOBL8Efxdg-2FEbO1=
4eQk-2FOxGrirWgibEq-2B4Cic7pByGUNpDJQzXczReh69SSb85vd072HduysQQG5XlblQwr2ug=
gk0p3iR7Hl7-2FIJzSGNW49ikxY2rkympbf4QptmkUYj65iUABRNG7yxtazELUaSWd-2FLJd7mc=
evFkBI4-3DeHu3_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEKYTQD8UoU0qdZeqM-2Bu24-=
2B1rD5bar1cSETAVA4Mp0KP3eQX4pkaKD4Phvhpb-2BPi4svX1t9-2FUTeP34LJQm4W1nS2FTuH=
4kOzG9Wcz2rbJllWsdodfRXMvV-2FiMdYbSvpFGAYszIshdQo6GdXHA-2FEqe-2FXqvDtwtwPGT=
ivk0Pj6ts10xHZgG8QuPbH5e2Zkk4t3QY-2BL-2BVyY-3D" rel=3D"noopener noreferrer"=
 target=3D"_blank">Financial Management, Budgeting and Auditing of Donor Fu=
nded Projects =C2=A0Workshop July 19 2021 for 10 Days</a></li></ul><div dat=
a-empty=3D"true"><br /></div><ul><li><a href=3D"http://url6478.fdc-k.co.ke/=
ls/click?upn=3DGLS-2FYQ6u7dEKmj0uSKpqemz299sgWAUYA-2F7kAumHSwLS5VptkbCFYtGC=
nE6B9eZI2DIGQVSiRE-2BsDdF1W63v1-2BbLg62NqlNQMtkStJWkJIhMlSDSgwAsFYPChu7UXLF=
AEHbLQFYvUCp01c769DDej9KG2MPn5ZQkSdirKMB-2BMzqfg635aPiQ24IgWgwHfQhmkgp2rArJ=
iJLK7iNEIdndnjBzlTpIsY80wp5HcYPKGB-2FBNidBwJGHvnnpCdh1BU21vet5J2EeSDA2Qsymd=
PMjU74qOsGbH3DC-2FVSuwyQznqXwuc6qr25fx9MWcFFpP8W-2B3sHLVELwMGOLRGHC7tiEUR8M=
1tcWmqMOnq1atwOOT2Z7h-2F5V9HOTVw3WZaT0K-2FCG90ZgYum6QUlGuOfh6rp9QtjYCgNsEwO=
Mr1VmMMYxqMaso-2BL8clMs7ewlMDgMuLI-2BoJrkKm-2Fb8YNWYR1T5pU-2F6-2Bg0eK5-2BhG=
ePexyRKwKAEnM-3DW9Ff_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEKYTQD8UoU0qdZeqM-=
2Bu24-2B1rD5bar1cSETAVA4Mp0KP3eQX4pk4QerLqWqiUJF-2Bh05Ay2szxpyhEzrc8Nwicxri=
13H1n-2FPTpGMnPntlGKi02HNt71AA4vJ8cuMl0oYUXBf7j7qToWWPLFuTfvyuaNsJ1XGAMJm9F=
Z3xlGlgel-2BT5D9z5HlGQKCuzcIOu1zKOAboZYSE-3D" rel=3D"noopener noreferrer" t=
arget=3D"_blank">Research Design, SurveyCTO mobile data collection,GIS mapp=
ing and data analysis using NVIVO and SPSS =C2=A0Workshop July 19 2021 for =
10 Days</a></li></ul><div data-empty=3D"true"><br /></div><ul><li><a href=
=3D"http://url6478.fdc-k.co.ke/ls/click?upn=3DGLS-2FYQ6u7dEKmj0uSKpqemz299s=
gWAUYA-2F7kAumHSwJlqPkoYsiMrSBOwtQTYrIWv9LnJ2Q1ydi3nIPICYr00CJuKMJc1IcdVyiZ=
74F1BauxyWnmtFHkYHzqG9RbalprUN8L9NfM-2FRf0VMT-2BJ7aBUvcgnl5Us-2BdDRlAiRj07m=
sSHGTzbwiG553gjb-2By8tm8pm63BH-2BYxeEg-2F9CAkGArrFE8ucOeC4geSEc4o9AP2fKTAtu=
B4ep4q7IN-2B6eNBXzzXXnZsxXIqgkhgEbv-2Bo8-2BZ0yedru5OCIFrMJIjSnzdDWSBQaNBcgj=
cRThaXqSGgeGGS6QjMqxaFgkkHwuA1Sg7yrz493scAM4nKHFCK2bqb4566fuENqWj5YaZyak77C=
-2Fh2IQSbfbx91eYgRsN43PAHBNBqgofJpN-2BaXNKE4O4Fjv-2FBNU6QDQCUZUCfVit9FknY1Z=
E5F0u9TEFL9ctpNV-2BXDiTGytF1WCO0FH8C14UDnY-3D46rT_6pwKHJ8Ph1XTyv7ONZlOBCAyk=
5EA9C6LJGdCEKYTQD8UoU0qdZeqM-2Bu24-2B1rD5bar1cSETAVA4Mp0KP3eQX4pms5Pa30MWDm=
TK3yYCcq-2FfcEJzCNwNtEY1SL4Za5QpKUPrTeKxg5St2LmO40Ir3dgdKZNfur4McHbfpCwG10P=
QPTi41w8IzWimn3YL-2FOQ65hzSwmMAFnNgy1N0XnEc7475r9FhcFoxQ4z7-2FDEfB1CIo-3D" =
rel=3D"noopener noreferrer" target=3D"_blank">Research Design, ODK mobile d=
ata collection GIS mapping, Data analysis using NVIVO and STATA Workshop Ju=
ly 26 2021 for 10 Days</a></li></ul><div data-empty=3D"true"><br /></div><u=
l><li><a href=3D"http://url6478.fdc-k.co.ke/ls/click?upn=3DGLS-2FYQ6u7dEKmj=
0uSKpqemz299sgWAUYA-2F7kAumHSwJJloxnJjCIedm2nWqQVo84WTqAdIHvJiPcN3k9Q6U0510=
H0XVjGMgAIJn7zsCCanvvmFFJOYgjXUWSgehmVYuJ7Gjan8aUn6sO-2BwEvhaaMONxesuUM-2F8=
NRpe8tl8HSYx8adTeWXSeX6WQwZ8F-2F5Q1Bxp3P0fSfJr4HvSMr-2FHzQgDHteL5t-2BdqukQn=
LMpqe-2F-2FfrG3S5RdAUyqsCI5QlaNxa4vut4kka8MQIZl4tfqFvlDEngeQruAAq-2BW3guQ-2=
Bp7uOXfv3dfqYQguVJz59HETmTNTQVkN50xcdCcjl69nQGLw-2F7XtYON0Eo9WCKD-2BLn3hXJX=
4H8lqKeNRer0C6p3xcRpFxD1yPcyAhCqXO2WqDojwM09e3-2F-2BnnFqCrKwkKQ0PHxG9dkZa-2=
FjMOWth0u3Qvz5luqkF0DHSCHK0qV5oJGSi7bPT-2Bc9jxwnCM0xHhYSlAw-3Dp0y9_6pwKHJ8P=
h1XTyv7ONZlOBCAyk5EA9C6LJGdCEKYTQD8UoU0qdZeqM-2Bu24-2B1rD5bar1cSETAVA4Mp0KP=
3eQX4phyqQAIXPbkhJ16ant4PvRDp1lcespoY1FBIfDfNSNA1vVwF9-2BX7m-2BHmlUseD0VAJw=
lINsbD0AkVwHkEgp6mn-2BSuTSPGA-2BpYEUwTdvNfDC0ZokpyvwpI2D-2B3Lld3sFVI0tousX2=
vcGGtImBm4-2FuiMcE-3D" rel=3D"noopener noreferrer" target=3D"_blank">Resear=
ch Design, ODK mobile data collection,GIS mapping Data analysis using NVIVO=
 and R Workshop July 26 2021 for 10 Days</a></li></ul><div data-empty=3D"tr=
ue"><br /></div><ul><li><a href=3D"http://url6478.fdc-k.co.ke/ls/click?upn=
=3DGLS-2FYQ6u7dEKmj0uSKpqemz299sgWAUYA-2F7kAumHSwKb8-2BJTbfGmmRfk7H6wCGvL2p=
7e1UUVgTHZlZEOH7OEXb6NCgUFEGiPHclXjZQAgEIlpMBJIb57KwBPUTK9eRNZL8ljcw3MI-2FW=
7EcdhFDO1iDmUTG6QhoVRpjXVvQZAa7qd1PibTl1L8OyjzUtRy8CJxTn1l6JFMoZkp-2FEalmRh=
gl7dTk1WzzuT8qsNE5EqREByRl-2BhwoZPeKeVbPzN0H1neza8hPWEy9Av3ZSCd4W0FAmx61YAO=
tpy-2Bf4wyyrzgwaRBJzvdlYxl8E-2FM18sHAIMM0iK8afY091-2FkczQpCSFCdS0gtcooAnbp-=
2FiieJ-2BgH8-2FGUHq2I-2B4ncHhWirjH9LzvgpLVGsmCBz2TCHtau5xJD-2Bx6J9cacT9g6lf=
5fKtoLQqoGMXmOIRh3YfdoMljt07j26u-2B0wgnrJLtHNjpug-2Fljkp5648-2BY9ld-2B8ggV2=
C-2BRss-3DfEaY_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEKYTQD8UoU0qdZeqM-2Bu24-=
2B1rD5bar1cSETAVA4Mp0KP3eQX4pmNqXQL8SGN5h6ix27EsD6RBvCxejyeD6AOszCcxXv4MzIt=
O5Co3JN5-2BMW5ToJxmBHoEr5KN7-2FyDtg8tobq3x3vvMTu9QflMD1gX9Wrnv1E-2FkcBoLDiS=
Tztndv3RJc-2B46tsK0vvbBZQd5TCDFRTQt6E-3D" rel=3D"noopener noreferrer" targe=
t=3D"_blank">Advanced Web-based Mapping Applications using Open Source GIS =
Tools Workshop July 26 2021 for 10 Days</a></li></ul><div data-empty=3D"tru=
e"><br /></div><ul><li><a href=3D"http://url6478.fdc-k.co.ke/ls/click?upn=
=3DGLS-2FYQ6u7dEKmj0uSKpqemz299sgWAUYA-2F7kAumHSwIABwFZdAUDNTrIYOtUpJoyXKXD=
mI6P-2BApcUI0N2Gzzth5FN-2BMCHVn1x8aHdDJ7KoT54c7BPTQzwgPxMaCWf8IkyXuIVw94Ji3=
PKw5IsGQ1hwj4wc7ShteQl9lKuGn1RRQqIqpa1pRlNyba-2B-2Bq3UX9o6f6lMTXloYIoTc6GO9=
hwYQIm4JQfEzzpKdnQzrxppY7-2BDMOokI-2BE8GVm5Y6IHC8YHps8w3MjkcNPPmr67JoObx53N=
pqzRkjL3wu-2BHSwW-2FiJ2aJHHm6mWo1fn6pmCaTCaRQhKLCKC5gr3hHVB242qLcNnkEQJO5Ug=
k6xSRfZ3oTKDCQVYoDi8nzxVFoBpAYSAeB5MGcp6Wv4HiD7mQ4-2Ff2AT6k2BNe00mdHaxbUIEL=
VuTGWYwBA9DeHYeMQ06ExaZff83h2cZ2MJAGotDy737U59sWqFx9sTDCbeETsd3NBo-3D9YZl_6=
pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6LJGdCEKYTQD8UoU0qdZeqM-2Bu24-2B1rD5bar1cSETAV=
A4Mp0KP3eQX4picbLbuZPNRwCOHkhs5WCHiBLOjcirmcCdl9mXA-2B7FXy8q9h7LIRlSYb2BT0m=
kvw3kHh8M3l1G-2FT2tgQ72wcU6BsSkbOzAPVhvJf8H-2FSlmNQy05MeDy5saNgT5fPlOrhLgLq=
NgJ6slvR2LYK5kX5zaE-3D" rel=3D"noopener noreferrer" target=3D"_blank">Elect=
ronic Document &amp; Records Management Workshop July 26 2021 for 5 Days</a=
></li></ul><div data-empty=3D"true"><br /></div><ul><li><a href=3D"http://u=
rl6478.fdc-k.co.ke/ls/click?upn=3DGLS-2FYQ6u7dEKmj0uSKpqemz299sgWAUYA-2F7kA=
umHSwI-2F7NdL9P9Y3CFgsBKOZ2b1-2BMNBJkN3aUArzlKA0V95l8qWgxdE-2FeRq6zN-2BnZ8M=
H9Hh3wuBUaw-2F9gAiOYDBRKFdsXqjucR1sJFv5FpztzsXjjSXzefYzIL-2BNJzwVzd-2BkMAB1=
806KM7FQn68m7WD0nmi9RWxOEbNXMrkQhlAZt1Kg7Bhc9yfufEzLDK-2FlxfWF3D3A2XiLPFmQt=
j8jBq8FApdo8GKtvl6hfrWiYS2MXGBHZvEhOJKc-2Fo-2F5buWDdHdvU8g6JaKwCqslNNCg8TX1=
fL14vTdZAyGJ3rFgdBD4pupjpGe-2BWKHZ71PKKgxSj0uc4MgkPq-2Bnpv0bGZFwsfzzCUIKJPA=
6tjh4K4-2FHe1-2B8y50i5wRcWINb3hoYmd185pX4tSDVFiJD6Rdc-2FGEsvaTh1w36YwCjVIi0=
qLulL4H-2Fhaoou2GvPxpItv6TshxbGVt53c-3DAqLC_6pwKHJ8Ph1XTyv7ONZlOBCAyk5EA9C6=
LJGdCEKYTQD8UoU0qdZeqM-2Bu24-2B1rD5bar1cSETAVA4Mp0KP3eQX4pknUy9CSzJNRgts6jR=
Ivrx7GYFqgljy09H8w5-2BUSGi-2F64Zs4v3SdrMByMTXzACOKVjArE-2FxggBnyG9R1UCPLZZV=
SJPjhFQmaU8SE3c-2FQJGN-2BEntC0tIRtcnpwfz6Hvg3htDsEM2g2na3haPNLtNgEdc-3D" re=
l=3D"noopener noreferrer" target=3D"_blank">Project Monitoring and Evaluati=
on with Data Management and Analysis Workshop July 26 2021 for 10 Days</a><=
br /><br /></li></ul><div data-empty=3D"true"><br /></div></td></tr></tbody=
></table>Looking forward to your =C2=A0attendance.</div><div data-empty=3D"=
true"><br /></div>FDC Result Based skills Development<br />Regards,<div dat=
a-empty=3D"true"><br /></div>Jackson Munene<div data-empty=3D"true"><br /><=
/div>Finance, Governance =C2=A0and IT Consultant FDC<div data-empty=3D"true=
"><br /></div>Training Coordinator<br />Telephone office: +254712260031<div=
 data-empty=3D"true"><br /></div>Personal No: +254729262303<div data-empty=
=3D"true"><div data-empty=3D"true"><div data-empty=3D"true"><br /></div><im=
g src=3D"http://info.fdc-k.co.ke/media/images/51a4337c8cef42c13752f96b79a35=
93e.png" class=3D"fr-fic fr-dib" style=3D"width: 944px; height: 92.4891px;"=
 width=3D"944" height=3D"92.4891" /><div data-empty=3D"true"><br /></div><s=
trong>You can opt out of future communications about our services by clicki=
ng on the unsubscribe link below.Thank you</strong></div></div></div>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </center>
        </div>
<img height=3D"1" width=3D"1" src=3D"http://info.fdc-k.co.ke/email/60cb5ff8=
e0a31327997699.gif" alt=3D"" />
If you'd like to unsubscribe and stop receiving these emails <a href=3D"htt=
p://url6478.fdc-k.co.ke/wf/unsubscribe?upn=3DoDb6ny51mUB6FExYn3rQhnEsRzMLZB=
2XMeq5leS37lBt4vf28x8LQy7hPCfosmiVzDDdzZQxVux4-2FgH7o68YUIfbhRWCh97iFSf41N9=
ajSOXTc-2FFEBRkUp9DaJeHuiTPm7cidRAU-2FkUOtI9vOSLq5q0dCVvIhzrG8dZuwPlfX7jcyY=
Dn1Y1WGKVIBBJjeZE77wPw8Hj8SPctNi7XJW4m33fYHjQ7aiVQw-2FEjpbwNaW0-3D">click h=
ere</a>.
<img src=3D"http://url6478.fdc-k.co.ke/wf/open?upn=3DoDb6ny51mUB6FExYn3rQhn=
EsRzMLZB2XMeq5leS37lBt4vf28x8LQy7hPCfosmiVzDDdzZQxVux4-2FgH7o68YUDG9mXv0H95=
55aKQyM-2FS6Toh8CcuC8TTdfopJKxp3of0A8QlvRXHl46gc4Rf-2B1VaeRBBAFxQAkYbkPUici=
PCejAP2dG9LbVUWM2MF9FczHnJu6Yu8tXeRR0iXXdffFqcsJz8NrvRbpv68tBs9QBbCyyFUSbfk=
-2F9Uqs7cGK9KX4k1" alt=3D"" width=3D"1" height=3D"1" border=3D"0" style=3D"=
height:1px !important;width:1px !important;border-width:0 !important;margin=
-top:0 !important;margin-bottom:0 !important;margin-right:0 !important;marg=
in-left:0 !important;padding-top:0 !important;padding-bottom:0 !important;p=
adding-right:0 !important;padding-left:0 !important;"/>
</body></html>
