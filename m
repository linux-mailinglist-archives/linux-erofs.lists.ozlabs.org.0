Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D2568B3B4
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Feb 2023 02:20:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P97jm2G35z3cGy
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Feb 2023 12:20:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=XZelh4mn;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=XZelh4mn;
	dkim-atps=neutral
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P97jg5Yqmz2xl2
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 Feb 2023 12:20:22 +1100 (AEDT)
Received: by mail-pl1-x62a.google.com with SMTP id z1so10566860plg.6
        for <linux-erofs@lists.ozlabs.org>; Sun, 05 Feb 2023 17:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPaIaDTpiZnSt1wjJurYQXRLG6/rtxljaG75dz1yn+Y=;
        b=XZelh4mntu6EgzfRSEYgaThUVQAQr44uPQzXztYXf3DyMZSJDEtZRM+saOb8NlYdM7
         r+qQIeOGyOo1Lt+Zqc5gjNK7f3BRjcXXJXH15neUe5lyMLzDCLbIelZmWKDVEBUNliLR
         lYvg873e4STTTbx52pfo1vLzXFeGbbfONXcAdGs1jt/jHv9qTR+LP2itFHnFI65nAzpi
         HTqa0RCcB9wvCfbUO7YU8sdnn5pI8Dxh8lwKZ2CkBN3E5Bw5ZLJiZ1y7WSKAN3eqVkPz
         a8qABQvsekqu3iwQHUQQW2BAnxoyzAIW+iYirS2EeC1qj2xhs23Fm/oi5fKixYVdHZmj
         GziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPaIaDTpiZnSt1wjJurYQXRLG6/rtxljaG75dz1yn+Y=;
        b=v5ybpZRv81nDbINQHkQlXnKoBUBJqDEIL4j4D2RbGw4pSWm6dpQf0MTxg3zX0kBEug
         lRy4uvUYGgseN5ZCglG28a44GvHNs0jCa4jARtLbHEPrkbKf5QSuUU52Q6OltCZg1FAA
         VNeGot0JMysOQJqkUYJ6eUMv9pRHUk9/K3S0BRMQINdIUH/hA+N05lsi3FQRvCEoO4mA
         ZCsbLekS9vfV9rckST6n7Oot7EkZdGJJ6pCYUAcY1ewv1CJUGaCiIJnB9k94J82ZjV/G
         IIkCo+NIGfgewItE3xEol6v+JS2Ye26Iiv7qfGoSksjw+2IUy/MaPhbn2u6L9M7DX3HZ
         batg==
X-Gm-Message-State: AO0yUKXqoHjLvrt/KX+eA5pfx3gih6vF5kf9rZ2I811wtesN670I5oW0
	S+7H+fp/kxAGaTJNm8pI1tc=
X-Google-Smtp-Source: AK7set9/HPDdL+PIdw4nlH3G0SSgKQgrmMsrUDuXM0Iz+pxkCtCT55/WsoNAmyifKqhRD0M1UBl+Xw==
X-Received: by 2002:a17:90b:3881:b0:230:af67:b847 with SMTP id mu1-20020a17090b388100b00230af67b847mr3129279pjb.31.1675646420024;
        Sun, 05 Feb 2023 17:20:20 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id f3-20020a17090a8e8300b0022c08b63564sm5144670pjo.52.2023.02.05.17.20.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Feb 2023 17:20:19 -0800 (PST)
Date: Mon, 6 Feb 2023 09:26:00 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 5/6] erofs: get rid of z_erofs_do_map_blocks() forward
 declaration
Message-ID: <20230206092600.00003c68.zbestahu@gmail.com>
In-Reply-To: <20230204093040.97967-5-hsiangkao@linux.alibaba.com>
References: <20230204093040.97967-1-hsiangkao@linux.alibaba.com>
	<20230204093040.97967-5-hsiangkao@linux.alibaba.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat,  4 Feb 2023 17:30:39 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> The code can be neater without forward declarations.  Let's
> get rid of z_erofs_do_map_blocks() forward declaration.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
