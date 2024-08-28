Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 42227962825
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2024 15:02:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wv4Lw6czNz2ymQ
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2024 23:02:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724850134;
	cv=none; b=fc5hw4oHxzsw/XS0AvLKjhLtaCmstzVbDOYIjZGC3AOBDPCQAdUK0qgz7sUyLieo0Ol0ormAGlnugUz2AxVya0qXZFHlR94ypO/4dF/jSPdxiu4glBYD0apUdfs9mIU3ltaP6VyvyNXf6D9ubnHmWwa2QVg8/eUKXRz69Yeys5RR3zFsUuLVIus7qO8uaRBKDT6oOKBNSseg3S+5/FL6WBprAIrmyRlpcgZAv6C7ui6tqdzqQb5iUOP+bB9XwjRXygzaBzuiAXRbWCT3Z5vZDAwPhuZcU1qALcO/bJMpDv/V05yGMlYeDnNbQmqZCoSKIsAUBeCpbWQrvu/eHRFM5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724850134; c=relaxed/relaxed;
	bh=6z9573j1PRy0mQEVayeHkT7XEBmXChvpYifI+rJKeeI=;
	h=DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:Received:
	 Received:Organization:From:In-Reply-To:References:To:Cc:Subject:
	 MIME-Version:Content-Type:Content-ID:Date:Message-ID:X-Scanned-By;
	b=I1lFdA8otdjti1gGFd3Q8DYO5x7QZ3Er4bHXMGJjmHlSgrqZiKuNbYWIPV9UWNyt0qcONWxqMshAf+O3qGB4IIMBSyr4WOz+sTOUppKvK8OBrlnlZl7/XYIzIHZMMxq2z7VqBdePBMbOilgmao4FpZWxf1z8YtnY9uVE7WUr3dgqsBTgRm0gvVo6GcDYzu0VFX3YLevctOSSl/YkXk+6DptIt57qmZP3kKon8OPEHrb0JOjKaXN/gNuP10vojC9uEAgra453Wz16vH7ROy0qME7i2iPV9oAipKfZCk5HockmVFYO2Ui2LEq+XhkCdGWa7BrdU1zrd0A9nwp5IOWGrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bcz6F3aE; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bcz6F3aE; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bcz6F3aE;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bcz6F3aE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wv4Lt0DSgz2yhP
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Aug 2024 23:02:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724850130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6z9573j1PRy0mQEVayeHkT7XEBmXChvpYifI+rJKeeI=;
	b=Bcz6F3aENkQVkbF8o5ZuT+krHHi2M4Gps9uP9MVX+r6hkRVoG2IddGueiMJ6ISXm88+QGR
	jUQc0yq/bm+aqRVeYzLfwh6tPMPrlsQXnYdUWw7K4Aze85VnH8A0dX9upwLCTlkN5P+HIM
	xTRCDub98haFUdG2tJdSxdhG201mmyw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724850130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6z9573j1PRy0mQEVayeHkT7XEBmXChvpYifI+rJKeeI=;
	b=Bcz6F3aENkQVkbF8o5ZuT+krHHi2M4Gps9uP9MVX+r6hkRVoG2IddGueiMJ6ISXm88+QGR
	jUQc0yq/bm+aqRVeYzLfwh6tPMPrlsQXnYdUWw7K4Aze85VnH8A0dX9upwLCTlkN5P+HIM
	xTRCDub98haFUdG2tJdSxdhG201mmyw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-dmP1IjVvOrejjqwGLa5RLQ-1; Wed,
 28 Aug 2024 09:02:04 -0400
X-MC-Unique: dmP1IjVvOrejjqwGLa5RLQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96FC41955D47;
	Wed, 28 Aug 2024 13:02:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.30])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AF17219560A3;
	Wed, 28 Aug 2024 13:01:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <5b7455f8-4637-4ec0-a016-233827131fb2@huaweicloud.com>
References: <5b7455f8-4637-4ec0-a016-233827131fb2@huaweicloud.com> <20240826040018.2990763-1-libaokun@huaweicloud.com> <467d9b9b-34b4-4a94-95c1-1d41f0a91e05@web.de>
To: Baokun Li <libaokun@huaweicloud.com>
Subject: Re: [PATCH] cachefiles: fix dentry leak in cachefiles_open_file()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <988771.1724850113.1@warthog.procyon.org.uk>
Date: Wed, 28 Aug 2024 14:01:53 +0100
Message-ID: <988772.1724850113@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
Cc: Christian Brauner <brauner@kernel.org>, Yang Erkun <yangerkun@huawei.com>, Jeff Layton <jlayton@kernel.org>, LKML <linux-kernel@vger.kernel.org>, dhowells@redhat.com, Markus Elfring <Markus.Elfring@web.de>, Gao Xiang <hsiangkao@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org, stable@kernel.org, Yu Kuai <yukuai3@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Baokun Li <libaokun@huaweicloud.com> wrote:

> Actually, at first I was going to release the reference count of the
> dentry uniformly in cachefiles_look_up_object() and delete all dput()
> in cachefiles_open_file(),

You couldn't do that anyway, since kernel_file_open() steals the caller's ref
if successful.

> but this may conflict when backporting the code to stable. So just keep it
> simple to facilitate backporting to stable.

Prioritise upstream, please.

I think Markus's suggestion of inserting a label and switching to a goto is
better.

Thanks,
David

