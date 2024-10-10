Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 627699983C3
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 12:35:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XPR3g0cMlz3bcJ
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 21:35:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728556524;
	cv=none; b=WkWhKfIlADE+4yqc7nKpygSuRLyzuKKFtIWB+gSWq+J9GDV1JuBwpshIU8z79EiZOfacoTAnbNBTpga9R1HqI8Aj9jbruhfPGaI31PUqtIO8fPaJd6ghYCX9ZI4hsNJLrh39SgZhD72/1Q8xEzWfWEFO/ThICGwxJk8P0CsMHX3Lif79fLPt+FZ01WRKezA1Yg4BK9wlTDsM9N+Zx7HXYvet1tOnAC/pk5XsKGVKYrnik3fevfFAP2mEtXymw97vKk9JShmu7j9QaJYsWsL+6KxG6A/qI73YMFi+AjUAlvh2jeibHyy/uoleNEsgo2NRZ9qA0A5FqdIpMFSIfUuhXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728556524; c=relaxed/relaxed;
	bh=zx+kPV8292G/Dzt3BTlua2EqMJ9Klq9hxRZJVfmtfTU=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=lY252bH8CcHoh0sqOu0IALgR09307f8Ql1utOA24xguOGP3ZnW7iDGfAx/uAOtnQUOyiKk3gscwU2fVFDIwZvP/E52KI+ZlJTUznOSIN3oOARQo01DcwM+cl98NLZTlD/qBkgfKSdBFJm3VSxE2rnT385iF5ziRA+67sWGJXPfuGz3eY/piMzQAAieQcrH+Sx3fk0wkCZCVQ/8hBdLqs36CH2+DN/EZ9/VUXwaJXyn5+xl5xvW4VV1KRpp4fBH94V/aOTU7cqvREJcWMEjT7m6nzxr+yrBlfl6Uf/rRcFvcj5w+HGXvwMzwuRWRYhag+G2DniPbFdT2UD6Teh6Vfjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UPYtyKd1; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rf9gFs7r; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UPYtyKd1;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rf9gFs7r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XPR3b3m4Pz2xwc
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Oct 2024 21:35:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728556514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zx+kPV8292G/Dzt3BTlua2EqMJ9Klq9hxRZJVfmtfTU=;
	b=UPYtyKd187OG8+u7cF6gtHxglLBUNnNyLBFFsrwJmW6/eDbc+Z4YxnOjrMMoM65+AcH6CC
	Kj6wVUNXvBGk8oJ8TauDdwHVjlp+TKlhbeIvTmRniShWdZtvxl2yjfE3WsVFJiBGk046oD
	sZyIW8rPCx8ebEGnMrAzZ1uv2Yb8iZI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728556515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zx+kPV8292G/Dzt3BTlua2EqMJ9Klq9hxRZJVfmtfTU=;
	b=Rf9gFs7rKaB1Xau3JAeKaP2o8/xAQrZeXaIKtz/k3fdEINffrY1892SJsMChpsKZkcRSf8
	PVcLBKGt/kALROPmM/ur4cb7/3mqeo+51hvUZ7S4fxHUCgkLFMybm2T0+JAekFbCqlaGVK
	c7M3/Aj4k4DicR1wovR+d1sY+ZJvU4Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-dLh36eegOY2DWn475u0HWA-1; Thu,
 10 Oct 2024 06:35:08 -0400
X-MC-Unique: dLh36eegOY2DWn475u0HWA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 518751955F3E;
	Thu, 10 Oct 2024 10:35:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 08CA11956089;
	Thu, 10 Oct 2024 10:35:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240821024301.1058918-2-wozizhi@huawei.com>
References: <20240821024301.1058918-2-wozizhi@huawei.com> <20240821024301.1058918-1-wozizhi@huawei.com>
To: Zizhi Wo <wozizhi@huawei.com>
Subject: Re: [PATCH 1/8] cachefiles: Fix incorrect block calculations in __cachefiles_prepare_write()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <302545.1728556499.1@warthog.procyon.org.uk>
Date: Thu, 10 Oct 2024 11:34:59 +0100
Message-ID: <302546.1728556499@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: yangerkun@huawei.com, jlayton@kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Zizhi Wo <wozizhi@huawei.com> wrote:

> In the __cachefiles_prepare_write function, DIO aligns blocks using
> PAGE_SIZE as the unit. And currently cachefiles_add_cache() binds
> cache->bsize with the requirement that it must not exceed PAGE_SIZE.
> However, if cache->bsize is smaller than PAGE_SIZE, the calculated block
> count will be incorrect in __cachefiles_prepare_write().
> 
> Set the block size to cache->bsize to resolve this issue.

Have you tested this with 9p, afs, cifs, ceph and/or nfs?  This may cause an
issue there as it assumed that the cache file will be padded out to
PAGE_SIZE (see cachefiles_adjust_size()).

David

