Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCB797F146
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Sep 2024 21:39:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XCCwg3FCcz2yVZ
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Sep 2024 05:38:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727120337;
	cv=none; b=Ba4WRyNvLo1WKQHPcbWWjXftAKGkDZF27Qwycp3OhJc5gh6lS7klDujVyIisR7NwhyhfQNVHgVA0gid7/hIcHrpmgLCx5+jbocARnAJNoJ/AI8eo7nEov2MN5XTWruBr3rCIdwtxauaobYIsL+qAmE906261DwRKu48h3s01+r6gMaPYOgu/O7AQNlu/ZGCIp65irtI/3kFlFanRq1G2zhmso18cuJ6JK3op0kN90Hc8H9VkUdwTluHl/8dCBEgFu1IHZmr1FY9gmq6Dv5F6boaelMECUQCi1jiJNF3yxl1SqzNH5USDjT7Rs8r2M3SibUgeRLimKDH1pxZWUcxVMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727120337; c=relaxed/relaxed;
	bh=IMBNE2puIfzdked4t6uZlyrCqjh8qel5HvLo5rRBc9o=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=g3PKxC7A5KzzH6JqPiyOpWgUwov3suiMPkkgcv/EiEenmj/3Ldndr9rWpfwp7qDEv1xbZnGnpGK0HPtTxb/T4ntovJ1kr/TVb1hLg6CErDemql2ra5ENU/qjBpOLAuQiS7NzNXYNoHdEKgIoB7uXz5p8E3imSlivu4om2q2HTZU2iTMijoxct9NNUyeRusy1/3O43TYjfanO8UpFyHA9Em9U5jgZA++8+oDh6TulKTBZxu3zvSiAmmCMqsuTc+0PhDeO6d0a7TKf7grd3odV5bPC9amosVMT/rgXmomgBYPq9XC1TdzAJLKlb5k5N7/3ic8kf74dmbtBlppsIQV3Ng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TI23T2Kk; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TI23T2Kk; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TI23T2Kk;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TI23T2Kk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XCCwc5xG1z2xJy
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Sep 2024 05:38:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727120330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IMBNE2puIfzdked4t6uZlyrCqjh8qel5HvLo5rRBc9o=;
	b=TI23T2KkqWztY/ozBwgBWCWixdncjHzaAhT4BTD9Zm6xmuB+9o5gATA8qjwVEndSoJAQZU
	8WoM0uZPj/FVWrZLg/6VkXd2KGovFdDanODj09fU/KLanjnfofSVdmND5yw5f9+W8upTz3
	kqQS2rFCiGt+COlhj7+5NB36QT2oVsg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727120330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IMBNE2puIfzdked4t6uZlyrCqjh8qel5HvLo5rRBc9o=;
	b=TI23T2KkqWztY/ozBwgBWCWixdncjHzaAhT4BTD9Zm6xmuB+9o5gATA8qjwVEndSoJAQZU
	8WoM0uZPj/FVWrZLg/6VkXd2KGovFdDanODj09fU/KLanjnfofSVdmND5yw5f9+W8upTz3
	kqQS2rFCiGt+COlhj7+5NB36QT2oVsg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-BsQ4RlIhNY-hYa32ClXl0w-1; Mon,
 23 Sep 2024 15:38:44 -0400
X-MC-Unique: BsQ4RlIhNY-hYa32ClXl0w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 521C5190DE19;
	Mon, 23 Sep 2024 19:38:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 71DD619560AA;
	Mon, 23 Sep 2024 19:38:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240923183432.1876750-1-chantr4@gmail.com>
References: <20240923183432.1876750-1-chantr4@gmail.com> <20240814203850.2240469-20-dhowells@redhat.com>
To: Manu Bretelle <chantr4@gmail.com>
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <912765.1727120313.1@warthog.procyon.org.uk>
Date: Mon, 23 Sep 2024 20:38:33 +0100
Message-ID: <912766.1727120313@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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
Cc: asmadeus@codewreck.org, dhowells@redhat.com, linux-mm@kvack.org, marc.dionne@auristor.com, linux-afs@lists.infradead.org, pc@manguebit.com, linux-cifs@vger.kernel.org, willy@infradead.org, smfrench@gmail.com, hsiangkao@linux.alibaba.com, idryomov@gmail.com, sprasad@microsoft.com, tom@talpey.com, ceph-devel@vger.kernel.org, ericvh@kernel.org, christian@brauner.io, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, jlayton@kernel.org, linux-kernel@vger.kernel.org, eddyz87@gmail.com, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Manu,

Are you using any other network filesystem than 9p, or just 9p?

David

