Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F3868B3F5
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Feb 2023 02:45:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P98GF6751z3cJC
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Feb 2023 12:45:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=CVOrYXEf;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=CVOrYXEf;
	dkim-atps=neutral
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P98G96NV6z2ypJ
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 Feb 2023 12:45:04 +1100 (AEDT)
Received: by mail-pj1-x102e.google.com with SMTP id bx22so7320050pjb.3
        for <linux-erofs@lists.ozlabs.org>; Sun, 05 Feb 2023 17:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnCWo4AAikXuZ3MEq0h3uZ00VDz0wRVmJZ9agLFsWm0=;
        b=CVOrYXEfZIXaPWopwnsNoos4/2/kLh2SSEF4H4H6UjF3XYdp0vCpHmWZf79tNP7zLc
         dX1ElMlw0u1XNAHLnWvw7t1e/g6bxeZriqQuf6aQ1+2zacjeY64mhbkyBRJnb4z2Lqty
         6h82A3nvwYsut4mTB9nqSIC3O4WHgHnigW3UN8HfCMjik9UBikt8TM99pWCysyl0L/x7
         3HzJY77Chrn3NjkdHFZ9k9FMONAk7GnJMTpYftSY2sU2oPtbYMPhWYFKNdPDB41ZUS6C
         mj88+Z2wIkzyJ22bId8U4DEx3zggYNs4IqcwrIqGQWkT40wh593OuWr3JcIHnn9CwNoj
         rm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YnCWo4AAikXuZ3MEq0h3uZ00VDz0wRVmJZ9agLFsWm0=;
        b=M2ZZnLK5cgVcv0d7Zw+r9xl6FTWukiO2jNO82Dhvv+aFCh3v4buI32IS2tJRrPO/Lm
         r8+KNlIovWazWOs2hR6ZgyoRkicglljSu1LzYzsFyskV94Ii/oEB2MkADL2i6Sxtkxf0
         fdTjxOnptLasE5HG8eFjpZaQFZatssuGuUW5SV18V/ud2QLx66sbTR5ODrwMmDOuoVsn
         DXElfhTbX2PICiNfAfFuCj+p3RL3/4NlSDt+E8YuD9ZVVz3Fcqhy89vocfd8C9sH41Tu
         QJojY3eIpDBkaEOz6qtUqmlor+TyaWERY7a+ROvOdTAyl9RLgc0EvlfoaCacz4HHxmki
         vKeQ==
X-Gm-Message-State: AO0yUKWmIGfUY7pppv65aL7Trde22u+ydmirGDOUxhOPERMOn4bSZfUJ
	9pdvX3L/BA0W7iVSRsH28p4kHDLk0Xk=
X-Google-Smtp-Source: AK7set+TBDGqJHxU1SXG0i6aacPGpcE/zA/ljipPknHQ3LUY8HyTPxg/DCxScV9FfMD3bWUv2JAARQ==
X-Received: by 2002:a17:902:c408:b0:196:e8e:cd28 with SMTP id k8-20020a170902c40800b001960e8ecd28mr25335941plk.15.1675647901977;
        Sun, 05 Feb 2023 17:45:01 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id m6-20020a170902bb8600b00177f25f8ab3sm5528616pls.89.2023.02.05.17.45.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Feb 2023 17:45:01 -0800 (PST)
Date: Mon, 6 Feb 2023 09:50:41 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 2/6] erofs: avoid tagged pointers to mark sync
 decompression
Message-ID: <20230206095041.0000140f.zbestahu@gmail.com>
In-Reply-To: <20230204093040.97967-2-hsiangkao@linux.alibaba.com>
References: <20230204093040.97967-1-hsiangkao@linux.alibaba.com>
	<20230204093040.97967-2-hsiangkao@linux.alibaba.com>
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

On Sat,  4 Feb 2023 17:30:36 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> We could just use a boolean in z_erofs_decompressqueue for sync
> decompression to simplify the code.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
