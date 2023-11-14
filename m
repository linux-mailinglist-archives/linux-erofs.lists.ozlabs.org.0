Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFD67EAB66
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Nov 2023 09:14:36 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=JgyW5zYk;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4STzbt2JDmz3cRq
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Nov 2023 19:14:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=JgyW5zYk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2001:4860:4864:20::2c; helo=mail-oa1-x2c.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4STzbp2YhCz3c40
	for <linux-erofs@lists.ozlabs.org>; Tue, 14 Nov 2023 19:14:29 +1100 (AEDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1f4e17c1edfso1671132fac.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 14 Nov 2023 00:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699949661; x=1700554461; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xq+h22Du6K4PHXdd1ehFCWVIecItR5XW1qYXi+x54PM=;
        b=JgyW5zYkt401FIQ8FBSr8hKMY6U/A3uAS28F9HBEm3KOCMbfoMqMd0DdlArRhJW8Er
         OwAa8eqJs1dADQFeJONCifle+ILkesZcOx3vn65Ey6ESVqemtImU1i3sagqU63FL67vy
         peqffuEDSobwY1wafjH14sjCdrnCcl4CCGxe7KheBF5mDd0qEOjod9J6xDzl6f23jv/W
         9cIVTbuaNB9Z4Xw5DQV0kWgoTXTQlKm297PPYYvZqT/y0BiwNPkCakCGKK+X8dA8+kAT
         5g0TCr2aJyMZxBum+AOiU3UX1wM1jlpyLUumyXMY8VLfYcrTbXOcldg/YvrXOIxTWXDl
         7a6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699949661; x=1700554461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xq+h22Du6K4PHXdd1ehFCWVIecItR5XW1qYXi+x54PM=;
        b=u2pwHch57qsqhe7HVYFFCRGnfWu/Ft00TNzK9nviSl6tLaxmvTl72com9mMqOGgnGW
         /RxGTOuas0kMprV9kg01dCBjdYVxzRx8ucdEWST7ucRnQZX2puTxWn8ad8kqHNHzcx4b
         nkS+BNAAhZbkrdpKGjE5RvYh7VCroZHncGzTFwq3hbu7KhU1Qmj4+awLDnWf8TM17s+9
         JcdtQ5jQgqzZkokq09XEfqk6VWrHCyHcdzvPLGhQ2SsTXT/73gM5TwPUba1HMKlkFeq7
         IBix3RjQo0FfoauC06egogSyCmt0/s5+iFl8gQZLaXNqCt6vAYBdWEk6s/5KQlixBOJU
         lQHg==
X-Gm-Message-State: AOJu0Yxyo/6JRl0wdm0xzXhI1fJZS3ZWxyjZeVoGNjt5HqIqSbz/FppM
	84/kaGEueQE1sHeqE/ID9gU=
X-Google-Smtp-Source: AGHT+IFuYjPTrbIlkYEyByLU3gz4oaeNkop4RzP+HqBwdaL6S14P6vWRpZNXzgY7TUAmzhBiqksJog==
X-Received: by 2002:a05:6870:3051:b0:1ea:69f6:fe09 with SMTP id u17-20020a056870305100b001ea69f6fe09mr12230979oau.10.1699949660885;
        Tue, 14 Nov 2023 00:14:20 -0800 (PST)
Received: from localhost ([156.236.96.172])
        by smtp.gmail.com with ESMTPSA id y15-20020a056a00190f00b006c624e8e7e8sm705281pfi.83.2023.11.14.00.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 00:14:20 -0800 (PST)
Date: Tue, 14 Nov 2023 16:14:15 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH] erofs: fix NULL dereference of dif->bdev_handle in
 fscache mode
Message-ID: <20231114161415.00003d8e.zbestahu@gmail.com>
In-Reply-To: <20231114070704.23398-1-jefflexu@linux.alibaba.com>
References: <20231114070704.23398-1-jefflexu@linux.alibaba.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, 14 Nov 2023 15:07:04 +0800
Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> Avoid NULL dereference of dif->bdev_handle, as dif->bdev_handle is NULL
> in fscache mode.
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>  RIP: 0010:erofs_map_dev+0xbd/0x1c0
>  Call Trace:
>   <TASK>
>   erofs_fscache_data_read_slice+0xa7/0x340
>   erofs_fscache_data_read+0x11/0x30
>   erofs_fscache_readahead+0xd9/0x100
>   read_pages+0x47/0x1f0
>   page_cache_ra_order+0x1e5/0x270
>   filemap_get_pages+0xf2/0x5f0
>   filemap_read+0xb8/0x2e0
>   vfs_read+0x18d/0x2b0
>   ksys_read+0x53/0xd0
>   do_syscall_64+0x42/0xf0
>   entry_SYSCALL_64_after_hwframe+0x6e/0x76
> 
> Reported-by: Yiqun Leng <yqleng@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7245
> Fixes: 49845720080d ("erofs: Convert to use bdev_open_by_path()")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
