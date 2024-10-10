Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB8D9984FF
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 13:32:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XPSJx3fLHz3bjq
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 22:32:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728559919;
	cv=none; b=PtzevZCjP4R7DPIgN8KU1R0jVDf9yK+ROaDEWQ30J9H4X2RrTTSKG12J82c0gzZGDbK4WL0vSEuX6TL4HPGv3z1tCf9oC4mHeG2qdG1JfPQJfGCTM/e+jDso85TKpryFDmTBl5uYEKU1BPvGu1gEiFeIUWX26MMVMSa4Ie8a78R1muwmjAraIy6bHMOUBXwj1hs4s6EH0jxYKBhptQg0eNkIpXTbdIL7y3gM4uO66anVwfG9k0f6JOp1lL77MsA80R7qU3MA3LaZ8E1HhP9pL+fCOy4WF0n/D3fGFYWDkstDYVeKmnCcsoT+qhQ5B9e8JJMM2xMcSgUj3HPOtXlQQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728559919; c=relaxed/relaxed;
	bh=P0mSN84ctC9kB+Ps3c0dqY7xkZFlxz3esb1cmK+QLag=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=OqFfe54jU5ZtS3DoyzkUZKLa/eQVdlqnsJ8gMfEPtt2m6W1rAawP2kWrDaqPTtQFcA417OkCiQ6/Ae45SK+hdzgQiU6wiTYhRHHAFWgf8MPs+ftCHxKAgEqJWBYt+VNnXU5ts7LvOhDSa1euc+mqhdUYHqBPBoCeqiWeoiWtwXwDyG83Iz7lPOIaSWlS+4AXCroIq359epPT5Dpe2813YIIjoR018bUiJLXNMZJjmtMdVQrey4+sb4dUsaYrWeWBqWngYWPG2rxew+eXttdYMYz+4lDvKob3qJPlmBPbI2wDrV/Sg5CGdEp8trHdM5tw7y2Qjg+iXbsIjZwIbJF8ZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RoQGcmGP; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RoQGcmGP; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RoQGcmGP;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RoQGcmGP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XPSJt5bBxz2xjw
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Oct 2024 22:31:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728559914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P0mSN84ctC9kB+Ps3c0dqY7xkZFlxz3esb1cmK+QLag=;
	b=RoQGcmGPLuAwVWfZD4P168qg/j+mp6ZvfY5pbuAe6s8q8iIWkO0s5NphQa6l5t/P7496tl
	0OP+RfIRY12D9I5lrneeZ/2uzQTjS2T4N0Tdqy6FqPV5u1IsWe4RT2ojRkqdrKy8rQCmxw
	AEXQMpSZWOnyVexVgjNKK9fMMrVlm1o=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728559914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P0mSN84ctC9kB+Ps3c0dqY7xkZFlxz3esb1cmK+QLag=;
	b=RoQGcmGPLuAwVWfZD4P168qg/j+mp6ZvfY5pbuAe6s8q8iIWkO0s5NphQa6l5t/P7496tl
	0OP+RfIRY12D9I5lrneeZ/2uzQTjS2T4N0Tdqy6FqPV5u1IsWe4RT2ojRkqdrKy8rQCmxw
	AEXQMpSZWOnyVexVgjNKK9fMMrVlm1o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-harA49VCM6mKEob86Vqu_Q-1; Thu,
 10 Oct 2024 07:31:48 -0400
X-MC-Unique: harA49VCM6mKEob86Vqu_Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C96A1955F44;
	Thu, 10 Oct 2024 11:31:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E65E819560AA;
	Thu, 10 Oct 2024 11:31:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240821024301.1058918-7-wozizhi@huawei.com>
References: <20240821024301.1058918-7-wozizhi@huawei.com> <20240821024301.1058918-1-wozizhi@huawei.com>
To: Zizhi Wo <wozizhi@huawei.com>
Subject: Re: [PATCH 6/8] cachefiles: Modify inappropriate error return value in cachefiles_daemon_secctx()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <304107.1728559896.1@warthog.procyon.org.uk>
Date: Thu, 10 Oct 2024 12:31:36 +0100
Message-ID: <304108.1728559896@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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

> In cachefiles_daemon_secctx(), if it is detected that secctx has been
> written to the cache, the error code returned is -EINVAL, which is
> inappropriate and does not distinguish the situation well.

I disagree: it is an invalid parameter, not an already extant file, and a
message is logged for clarification.  I'd prefer to avoid filesystem errors as
we are also doing filesystem operations.

David

