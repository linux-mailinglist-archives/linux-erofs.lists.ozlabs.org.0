Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8968978041D
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Aug 2023 05:03:02 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=NnPKA/hy;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RRms032NGz3c3f
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Aug 2023 13:03:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=NnPKA/hy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RRmrs4LGnz2xHK
	for <linux-erofs@lists.ozlabs.org>; Fri, 18 Aug 2023 13:02:51 +1000 (AEST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bdb7b0c8afso3538565ad.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 17 Aug 2023 20:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692327769; x=1692932569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miWNEdxtYXAMssImnpzpcTIiOJ1ID64VjwvMaMslPAU=;
        b=NnPKA/hykxy5RC3XYxGMOISOemOV6D3Bkhn4KuibYaou7bhVkPimm8ZrEVwaSvnPBm
         D1Zz2hiCr5GWso6gDqp6gJLtlTjyWbS2jjIWR+++HMuxasCaUWo0K2CjWK3kHErwfJ9d
         Wa5fTRGVKkNrPduKbAPLt5Iu2RPmlirwhiYJdo4HOHDbPevJ53QDdrXKOzCltWXnFkvq
         z2YBZq8kXgO/pzVwuFtgfaVZRdJ+GBoDtIEz9B0NArjfgkC9mSwptlr6ZJ9SEndFHY/g
         /yP7sdQqx22qStnXPEOvWdn0R2F14HO0tGK0zigiReyq/BO4cT15v5qXaHve6tnGPwBY
         NEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692327769; x=1692932569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miWNEdxtYXAMssImnpzpcTIiOJ1ID64VjwvMaMslPAU=;
        b=h6ozZJU8+bXkxaS3Ggfc5wW/2JZ6p0mJ5vexDf26bBCpYg51DtmMCItOkfX7sPeqMZ
         jRytJKne/76D35U8r0M3pA+Y7BqumnjaMP6e0JoE5dsd6zYu/EYOfIj8G+45ODhEHU/q
         wEZSGDf8PpqKnsHM77DYt2zJt042il8GI2X4N2Uv/6FGoDt3XLnP41gDNO6ydNeTNX1g
         EBAqORWCs2R4SiE4MI09WMMsyEzH+Wx5KYaelfp8QRSyXNlkhYl5RvJA1MSFTYq7kWlx
         BxxfWENTVdrzAg2BLUYrryzaopM5H7yFSSe3bKLXfSMZeChcuj27Dmx9JjQWNIYHfuE4
         PxeA==
X-Gm-Message-State: AOJu0YyR3LsWsjU+RWrSddWc/TR5NSH3UXJsJ9QUZV1b/qMizCR5DPOl
	OfbUi0XtljIeyPPoCPza45M=
X-Google-Smtp-Source: AGHT+IGRoOhYReSfwhcJDpFVLu9kstsEPejNu6LIvWatAl7zO7V5WzDTO/SzR4pnuimVfKsvAcn5Gg==
X-Received: by 2002:a17:902:d2c4:b0:1b3:cf98:a20b with SMTP id n4-20020a170902d2c400b001b3cf98a20bmr1364493plc.54.1692327768752;
        Thu, 17 Aug 2023 20:02:48 -0700 (PDT)
Received: from localhost ([156.236.96.163])
        by smtp.gmail.com with ESMTPSA id i1-20020a17090332c100b001bbf7fd354csm481992plr.213.2023.08.17.20.02.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Aug 2023 20:02:48 -0700 (PDT)
Date: Fri, 18 Aug 2023 11:12:31 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 4/8] erofs: tidy up z_erofs_do_read_page()
Message-ID: <20230818111231.00005ddc.zbestahu@gmail.com>
In-Reply-To: <20230817082813.81180-4-hsiangkao@linux.alibaba.com>
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
	<20230817082813.81180-4-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 17 Aug 2023 16:28:09 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

>  - Fix a typo: spiltted => split;
> 
>  - Move !EROFS_MAP_MAPPED and EROFS_MAP_FRAGMENT upwards;
> 
>  - Increase `split` in advance to avoid unnecessary repeat.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
