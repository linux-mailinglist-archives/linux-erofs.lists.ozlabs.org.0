Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062B447AA8F
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Dec 2021 14:46:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JHgpg5tY0z2yms
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Dec 2021 00:46:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1640007963;
	bh=c8dFInFAAiwiq02NwZUpjgZWFCygO22eZSXhNsMVBks=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=nYSpUDS3UD+IxVd5ieFtsBpiwrBPpjO9P3OeSNwHOlA4x0t5hTc/xaHPzkrIbd3tb
	 HSkSIIM06qb2H/SPdHzlF03QhFezL5om33Ipydz/+buwjgpVgQ94fKmoNBQTCY2PSn
	 rAbLz7AK43lpdBENaEs2hsxxiK1fimEdchw9dxPDx0R12fFrbjGAeqib44tfgfPezy
	 c0dJqR9F9jr2SpCLjJDdHtwgzGgo+1rC9rZexyPBVzPuoUqv/2Es+6BAB1bc5bNvSV
	 kVbSNtC+53zxgMG1zXMag4U1cR4/5WeiGAwd2/uF2D14lm4KEVN3D2MeQYEgMpA74R
	 qqFXhRxYW8yAg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::731;
 helo=mail-qk1-x731.google.com; envelope-from=zhangkelvin@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=akt1EXMR; dkim-atps=neutral
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JHgpZ6r5Hz2yQG
 for <linux-erofs@lists.ozlabs.org>; Tue, 21 Dec 2021 00:45:56 +1100 (AEDT)
Received: by mail-qk1-x731.google.com with SMTP id d2so9284493qki.12
 for <linux-erofs@lists.ozlabs.org>; Mon, 20 Dec 2021 05:45:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=c8dFInFAAiwiq02NwZUpjgZWFCygO22eZSXhNsMVBks=;
 b=eLUqhw/iFgum7QqkhIWUAlNObfT7EDnD5V/J/hskoWfMIPjBx9GzvE9VozeLxTDHc2
 Rds1e+HuJNm4vTumleWwm17gz+xXvpFEeBVn9su0VKaCft8ZtulSGE+v0wul+4dAHj/U
 iaz9dPHxY0TZCw4ENeZj0UFRKvJRLROpeLp+ex1sx3Dp+zII6Yu7vWW1iGaRWYpcTTu6
 TNI0U2/OOGgE8tA2sWbiNGaTa5wrwntLwD+3UtBJxbkH1aga0Ut4ObV8yJqBKLClBstK
 qL+LliwO7heC1AfvbskQfOLNzkehBF1mUXgnqfwLcUn+eQnW5zQLzKNm+X7hyzPtxpr/
 /l7g==
X-Gm-Message-State: AOAM531IKnDr8HWdjGdOn54t3b1Iuh1OyxDVIugm+MCEAqerc2b/rf71
 YHcLJbrvX/jYgzUgVPhATmqCswAOAKWQpaoZLghpwAkWIY1jHA==
X-Google-Smtp-Source: ABdhPJxSuHG1WNm26SuMsS/yu+8BVE7P53XOg/G2r6H4pUttoWm3lmXMAcw/1zQPHmf5MLTaYCrG50YFROP76901hBk=
X-Received: by 2002:a37:a88c:: with SMTP id r134mr9620628qke.671.1640007953067; 
 Mon, 20 Dec 2021 05:45:53 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 20 Dec 2021 08:45:42 -0500
Message-ID: <CAOSmRzhPk4ykswcUTnK0bj2LdmJ9iwcNuzDpgPQj20d2_rf4Dw@mail.gmail.com>
Subject: Practical Limit on EROFS lcluster size
To: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
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
From: Kelvin Zhang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Kelvin Zhang <zhangkelvin@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Gao,
    I was playing with large pcluster sizes recently, I noticed a
quirk about EROFS. In summary, logical cluster size has a practical
limit of 8MB. Here's why:

   Looking at https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/tree/lib/compress.c?h=experimental&id=564adb0a852b38a1790db20516862fc31bca314d#n92
, line 92, we see the following code:

if (d0 == 1 && erofs_sb_has_big_pcluster()) {
        type = Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD;
        di.di_u.delta[0] = cpu_to_le16(ctx->compressedblks |
                Z_EROFS_VLE_DI_D0_CBLKCNT); // This line
        di.di_u.delta[1] = cpu_to_le16(d1);
} else if (d0) {
        type = Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD;

        di.di_u.delta[0] = cpu_to_le16(d0);  // and this line
        di.di_u.delta[1] = cpu_to_le16(d1);
}

When a compressed index has type NOHEAD, delta[0] stores d0(distance
to head block). But The 11th bit of d0 is also used as a flag bit to
indicate that d0 stores the pcluster size. This means d0 cannot exceed
Z_EROFS_VLE_DI_D0_CBLKCNT(2048), or else the parser will incorrectly
interpret d0 as pcluster size, rather than distance to head block.
    Is this an intentional design choice? It's not necessarily bad,
but it's something I think is worth documenting in code.


-- 
Sincerely,

Kelvin Zhang
