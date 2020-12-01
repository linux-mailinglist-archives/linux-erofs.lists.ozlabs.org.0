Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9322CA1BF
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Dec 2020 12:49:05 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ClgNt6LWnzDqvl
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Dec 2020 22:49:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52b;
 helo=mail-pg1-x52b.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Pr61qy0D; dkim-atps=neutral
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4ClgNc3s6lzDqsX
 for <linux-erofs@lists.ozlabs.org>; Tue,  1 Dec 2020 22:48:46 +1100 (AEDT)
Received: by mail-pg1-x52b.google.com with SMTP id g18so1073718pgk.1
 for <linux-erofs@lists.ozlabs.org>; Tue, 01 Dec 2020 03:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JAuHd2zDd98nNlKDaDEYcmP2XtgOxFnaVuVrO3CT9UA=;
 b=Pr61qy0D3M0PUtrfAOv3ylP2WOLiXUuiGyPJq31EPihVY3yt1sWjK2X8JkTbgUm9fD
 2g3cOZu+ABJk6iakww5vf7KZtpfbpo3WwAfGtiQVWU62yzVUyJ8HkSokDx04dhCJJX3t
 R4ZoXw7xJ/RVo0rgbosbpMRM1PKhYLx8vVOJJ5ddEiBcF6rOCIBtBqgwfPq5X8hAa5FU
 HIlhA6X4LsfQg7RmO0I9kYiDg8yddZLD0u/Hr/YZPbLrynmRUbkfl5ru61M9THzD2MUP
 AvhwPxv/hCqlsBJuNwgsUbqp9q3Td/H75UxPJ3IV8O2gDoXn8o8z3C3KAqi0zAMQzcrr
 S9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JAuHd2zDd98nNlKDaDEYcmP2XtgOxFnaVuVrO3CT9UA=;
 b=ExxMQmJ9Hjzs0kPbVoW+sEdpoMsc9rE4dVQnOicXjk6weAzZqteNLD1iuiIz4hwieG
 f66GSuKUFfTH0HBE+mgm1d3ziPw+DXhnDQDXbq8NG4c+v1x0WeI7Hy8CyxNAS32ITrnb
 2AwUCqSE+fPUDMhWZxD6HNYNGZ9Yj2tQfHCA56iUqEb9vkh0SdJZW7jEggIvYVrk9mFv
 lxGc3ehyWgxSaBOLP8hk7CZjkQpjZiIbcgB8BpMF078QOJDguGepvtYqWT+H3WbP8WPj
 Xfehs7qqSTozS0e4v6Mgm9tspBS4DaaXxsM1O+6BzF2Y992rOZgiDPFuVk5ZNbaiMOw6
 7BtQ==
X-Gm-Message-State: AOAM533IHvrLjy9YUo3mVlbutIpEDaQzID4FWNn44yPmOCtGmgwol1MW
 o7h/MVNlr7nPqx0lRsmE+BQ=
X-Google-Smtp-Source: ABdhPJwOsKyGTBH4GDKQ1faXDrIN/qviruytz6OO9vZ5PffQ3nMYArGVRO9z5xygCCO+76BiC1oyvQ==
X-Received: by 2002:a63:5150:: with SMTP id r16mr1985797pgl.123.1606823322424; 
 Tue, 01 Dec 2020 03:48:42 -0800 (PST)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id m3sm2306442pgh.5.2020.12.01.03.48.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 01 Dec 2020 03:48:42 -0800 (PST)
Date: Tue, 1 Dec 2020 19:48:43 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: Re: About Segmentation fault of mkfs.erofs in AOSP
Message-ID: <20201201194843.000068c5.zbestahu@gmail.com>
In-Reply-To: <20201201114253.GA1323470@xiangao.remote.csb>
References: <20201201192309.00007531.zbestahu@gmail.com>
 <20201201114253.GA1323470@xiangao.remote.csb>
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
Cc: huyue2@yulong.com, linux-erofs <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, 1 Dec 2020 19:42:53 +0800
Gao Xiang <hsiangkao@redhat.com> wrote:

> Hi Yue,
> 
> On Tue, Dec 01, 2020 at 07:23:09PM +0800, Yue Hu wrote:
> > hi guys,
> > 
> > I'm trying using erofs for super.img(dynamic partition) under Android 10. But i have met an issue below when building images:
> > 
> > ```log
> > EROFS: write_uncompressed_block() Line[140] Writing 3517 uncompressed data to block 63950
> > EROFS: erofs_mkfs_build_tree() Line[1011] add file /tmp/merge_target_files_jnIVhM/output/VENDOR/etc/xtwifi.conf (nid 8185600, type 1)
> > EROFS: erofs_mkfs_build_tree() Line[1011] add file /tmp/merge_target_files_jnIVhM/output/VENDOR/etc (nid 1790208, type 2)
> > out/host/linux-x86/bin/mkerofsimage.sh: line 79: 188014 Segmentation fault      (core dumped) $MAKE_EROFS_CMD
> > ```
> > 
> > Have you met this kind of issue? I'm trying to debug the problem, looks like memory related.
> > 
> > BTW: i'm using latest erofs-utils in AOSP master branch (https://android.googlesource.com/platform/external/erofs-utils/).  
> 
> Which lz4 version is used? it would be better to use lz4 1.9.3
> (or 1.9.2 with some unexpected CR issues.)

Hi Xiang,

ok, let me check.

> For more details, please see README.
> 
> If the expected lz4 version is used, could you kindly leave gdb
> backtrace message here as well? 

Trying to get the bt for the case.

Thx.

> 
> Thanks,
> Gao Xiang
> 
> > 
> > Thx.
> >   
> 

