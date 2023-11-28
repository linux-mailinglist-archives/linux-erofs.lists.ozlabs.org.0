Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9547FB6B3
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Nov 2023 11:05:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1701165952;
	bh=ZKJsy/O9sQNKnNFyRJVuTOt01SElG6aFkPQ2+Lfq3iI=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ee9Nd1GsAYLuubb9B/1MbKnF4cXB7VVdfNUlaSb9JzRENu4VfE9LsQKbvHb+rogFR
	 WgzpGHOOhmlWuJQebaWSAflfbtHL68yqI/IsBYARK4hwsC02A1Rq+h/W68ZjXxax0u
	 kUKnubjv1jR+n9t1aS7z7tnNEN0jMd39jwDo/5iXlJrOtjY7ky+zvjMgIdPvlw3A31
	 dcGBOexFcuuMAdsvl4vEA5k0hLLmWtramGZ8Ws0lVS/l21gcdN3Es4lOEa7fiN9vDq
	 6kTqeEma9vVlSrgDwaeJtLJ+jUFxIrqnGJpsO/pPKUYObBqj3+y9X1b1PG2Ii3bWJq
	 c3GrShXqe1FfQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SfdPr0XT2z3cJW
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Nov 2023 21:05:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=citrix.com header.i=@citrix.com header.a=rsa-sha256 header.s=google header.b=M70xed5P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cloud.com (client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com; envelope-from=roger.pau@cloud.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SfdPg5JgSz2xgw
	for <linux-erofs@lists.ozlabs.org>; Tue, 28 Nov 2023 21:05:42 +1100 (AEDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32fdc5be26dso3247159f8f.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 28 Nov 2023 02:05:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701165931; x=1701770731;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKJsy/O9sQNKnNFyRJVuTOt01SElG6aFkPQ2+Lfq3iI=;
        b=rDGxZM0V74nE2kRVevT15MIoahngqHLQVnsdxNKfO1YvwjqbgSVN40LHZBEofE2ATB
         SyrbztxrkX8xl+R3ySmBqtf/PKEfn5XJwiUfHtM4J+bzwTB/TbNvaAmhBKUtf2pdSPzF
         Omlaopj4PcII0q9VViyi2g8icXxdntq/K2Xis+gGRA1BPdxKYZ7BeL9zgeeuZYkGtgbD
         LrvbDcX6pJQuj4OEHHzXrUE+l3LGvDXSaa9eZZVxSutF9WmSret23taxrtg+EGSsM4xG
         Q+vQ2tcVI779SGICRBPoOU8cuctVMqWs8yFXjYQxi5j2gAajbU1aZ30QRFq/i0ecfBx4
         K8DA==
X-Gm-Message-State: AOJu0YwDSUtZYqK/qsYv+/9M4jSANVyTpkyFbQ+hgOHf1ywReLEtKOc2
	n+yUV4kSRjs0yz8K4McYuWFI0Q==
X-Google-Smtp-Source: AGHT+IHso67qiRejATVe+y4q8GA8WkjBME6ZXNG2nx2AvipjQBf9Fe7u/GIhGV/RuBTAoKaGDDxyQg==
X-Received: by 2002:a5d:4bcf:0:b0:332:f81d:8dac with SMTP id l15-20020a5d4bcf000000b00332f81d8dacmr6833150wrt.67.1701165931581;
        Tue, 28 Nov 2023 02:05:31 -0800 (PST)
Received: from localhost ([213.195.113.99])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d674a000000b00332eef1ca7asm9779426wrw.80.2023.11.28.02.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 02:05:31 -0800 (PST)
Date: Tue, 28 Nov 2023 11:05:30 +0100
To: Yu Kuai <yukuai1@huaweicloud.com>
Subject: Re: [PATCH block/for-next v2 02/16] xen/blkback: use new helper to
 get inode from block_device
Message-ID: <ZWW7ag6vIhc_Skh5@macbook>
References: <20231127062116.2355129-1-yukuai1@huaweicloud.com>
 <20231127062116.2355129-3-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231127062116.2355129-3-yukuai1@huaweicloud.com>
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
From: =?utf-8?q?Roger_Pau_Monn=C3=A9_via_Linux-erofs?= <linux-erofs@lists.ozlabs.org>
Reply-To: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Cc: hoeppner@linux.ibm.com, vigneshr@ti.com, yi.zhang@huawei.com, linux-kernel@vger.kernel.org, gfs2@lists.linux.dev, clm@fb.com, adilger.kernel@dilger.ca, miquel.raynal@bootlin.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, agruenba@redhat.com, linux-scsi@vger.kernel.org, linux-bcachefs@vger.kernel.org, richard@nod.at, willy@infradead.org, hch@infradead.org, xen-devel@lists.xenproject.org, yukuai3@huawei.com, linux-ext4@vger.kernel.org, jejb@linux.ibm.com, p.raghav@samsung.com, gor@linux.ibm.com, hca@linux.ibm.com, joern@lazybastard.org, josef@toxicpanda.com, colyli@suse.de, linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, dlemoal@kernel.org, sth@linux.ibm.com, dchinner@redhat.com, dsterba@suse.com, ming.lei@redhat.com, konishi.ryusuke@gmail.com, axboe@kernel.dk, brauner@kernel.org, tytso@mit.edu, martin.petersen@oracle.com, nico@fluxnic.net, linux-erofs@lists.ozlabs.org, yangerkun@huawei.com, linux@weissschuh.net, kent.overstreet@gma
 il.com, hare@suse.de, jack@suse.com, linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org, akpm@linux-foundation.org, min15.li@samsung.com, linux-btrfs@vger.kernel.org, viro@zeniv.linux.org.uk
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Nov 27, 2023 at 02:21:02PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Which is more efficiency, and also prepare to remove the field
> 'bd_inode' from block_device.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Roger Pau Monné <roger.pau@citrix.com>

Thanks, Roger.
