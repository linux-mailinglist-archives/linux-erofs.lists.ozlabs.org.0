Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E5B2E77AC
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Dec 2020 11:13:08 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D5Rtn5pb5zDqHb
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Dec 2020 21:13:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=JMBBUnlc; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JMBBUnlc; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D5Rth0KQ8zDqHF
 for <linux-erofs@lists.ozlabs.org>; Wed, 30 Dec 2020 21:12:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609323173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TDx6tpRIbtVu0i9t7660U7MqY9d/Z6y580AhR3let+I=;
 b=JMBBUnlcUTgdOQ7dUr4rlldHtHwDGf0mqfnnyVcrFXhE4jDFrD4X20W9oE93tsjio5FBgS
 odPoLh9oTNZilxFsd/fDWJoKZonSr7rH6LBipEfb4sV6Ls9lR9WuXKTGLgldglndY9ulx2
 w4RIoLZTvlgbCgIzeo1zy6RG4waENho=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609323173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TDx6tpRIbtVu0i9t7660U7MqY9d/Z6y580AhR3let+I=;
 b=JMBBUnlcUTgdOQ7dUr4rlldHtHwDGf0mqfnnyVcrFXhE4jDFrD4X20W9oE93tsjio5FBgS
 odPoLh9oTNZilxFsd/fDWJoKZonSr7rH6LBipEfb4sV6Ls9lR9WuXKTGLgldglndY9ulx2
 w4RIoLZTvlgbCgIzeo1zy6RG4waENho=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-Rd9F43TlNKyJY9FWshxGag-1; Wed, 30 Dec 2020 05:12:50 -0500
X-MC-Unique: Rd9F43TlNKyJY9FWshxGag-1
Received: by mail-pf1-f200.google.com with SMTP id v138so5732679pfc.10
 for <linux-erofs@lists.ozlabs.org>; Wed, 30 Dec 2020 02:12:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=TDx6tpRIbtVu0i9t7660U7MqY9d/Z6y580AhR3let+I=;
 b=sUoo1lLQ7s9SDTTi5EzWf4NiArYPbDNFcCmj80LnczZ5W6NtlRGtP8lDpcrRWPNUXj
 27A+Je9Pdkv/RoTgeI4tsqaQHAFp0DFyV3fzvUN71lG1O1UiG19D187epVaXrdohPN/m
 WX/NKF9OjneTcaSbahlA8ymgS4PqC8A7AfVKo+WSsivSoszhNJz3p7+Q4Kazg/Ws9SQW
 8jackutCLXH2bjJ3T1opaYF6p8CwQt6IDxWghbSqvJzbiFF8GfrorYsBzC+qBfBToGgh
 5pd8qRuOhKkKqV5dYu93HV85BXP1Ga5uH7aXLjvhcvZYPidhS4WCdvV8XWlDySbMePkb
 OuTw==
X-Gm-Message-State: AOAM530Vdi1EJ2lvJVbNC9KJOAW/mmU2LROWYy8vWrt7jqC02Cu6l85e
 4uufH4cg7y3T6v8NBNt0o/MJLt8j/CU11e4uZvDk1/4oqzO1IoH+UGInnMOO0lrxg07a+/t0on+
 q+BhLQnRB7jlqJ6sc0WF6dyK9hM6gjzrDxNSZDw+AdpJ7dGAXatOLraP3Z5rKLXGC2ddjzejGAy
 at0w==
X-Received: by 2002:a63:5866:: with SMTP id i38mr51703670pgm.26.1609323169664; 
 Wed, 30 Dec 2020 02:12:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzfSf1fjkt+VPi3aGi8gJ1bXjVFmVo+LZgbeKC1mj9da6hlRJmjsolx/MSbPubmd49H6f1qvw==
X-Received: by 2002:a63:5866:: with SMTP id i38mr51703658pgm.26.1609323169423; 
 Wed, 30 Dec 2020 02:12:49 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 82sm43301904pfv.117.2020.12.30.02.12.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Dec 2020 02:12:49 -0800 (PST)
Date: Wed, 30 Dec 2020 18:12:39 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: linux-erofs@lists.ozlabs.org
Subject: Re: [RFC PATCH v0 0/3] erofs-utils: support multiple block compression
Message-ID: <20201230101239.GA3282742@xiangao.remote.csb>
References: <20201230084728.813-1-hsiangkao.ref@aol.com>
 <20201230084728.813-1-hsiangkao@aol.com>
MIME-Version: 1.0
In-Reply-To: <20201230084728.813-1-hsiangkao@aol.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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

On Wed, Dec 30, 2020 at 04:47:25PM +0800, Gao Xiang via Linux-erofs wrote:
> From: Gao Xiang <hsiangkao@aol.com>
> 
> Hi folks,
> 
> This is the first RFC patch of multiple block compression (including
> erofsfuse) after I carefully think over the on-disk design to support
> multiblock in-place decompression.
> 
> Compression ratio results (POC, lz4hc, lz4-1.9.3, not final result):
> 	1000000000		enwik9
> 		621211648	enwik9_4k.squashfs.img
> 	 557858816      	enwik9_4k.erofs.img
> 		556191744	enwik9_8k.squashfs.img
> 		502661120	enwik9_16k.squashfs.img
> 	 500723712		enwik9_8k.erofs.img
> 		458784768	enwik9_32k.squashfs.img
> 	 453971968		enwik9_16k.erofs.img
> 		422318080	enwik9_64k.squashfs.img
> 	 416686080		enwik9_32k.erofs.img
> 		398204928	enwik9_128k.squashfs.img
> 	 395276288		enwik9_64k.erofs.img

I can also think out several compress strategies to control read amplification
but maintain a given C/R due to EROFS can compress variable-sized input data
to arbitary compressed block count for each pcluster, FYI.

Thanks,
Gao Xiang

