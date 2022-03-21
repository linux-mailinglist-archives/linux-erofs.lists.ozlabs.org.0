Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B8D4E2A55
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Mar 2022 15:20:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KMcGg54DLz30Lq
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Mar 2022 01:20:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q4o6sZ3s;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q4o6sZ3s;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=Q4o6sZ3s; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q4o6sZ3s; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KMcGb5L2Sz2yxV
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Mar 2022 01:20:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647872435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pssBTLPsJmSQSwv+152p2Hsi/lwPzOT3VeLQVfSuxQg=;
 b=Q4o6sZ3sWaHqKXTzUYwD6PMTu+O9bH0cYtg8gMEaaVeTpzK4CEiww0aVmBnuewe2OTd86G
 dKtk1SCn6Z9Qw6LM2gN/tgVkgJbnigZXYBza3UWOOby9UEZyx+vqsoU97qr0vEbM9SDqDg
 MH6FORB+HH/Q7b1dbDxt1flnr1wr2ZE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647872435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pssBTLPsJmSQSwv+152p2Hsi/lwPzOT3VeLQVfSuxQg=;
 b=Q4o6sZ3sWaHqKXTzUYwD6PMTu+O9bH0cYtg8gMEaaVeTpzK4CEiww0aVmBnuewe2OTd86G
 dKtk1SCn6Z9Qw6LM2gN/tgVkgJbnigZXYBza3UWOOby9UEZyx+vqsoU97qr0vEbM9SDqDg
 MH6FORB+HH/Q7b1dbDxt1flnr1wr2ZE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-599-I_3I7TfiM8aekFXq74AeEQ-1; Mon, 21 Mar 2022 10:20:31 -0400
X-MC-Unique: I_3I7TfiM8aekFXq74AeEQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C6231802C16;
 Mon, 21 Mar 2022 14:20:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A5B48492C14;
 Mon, 21 Mar 2022 14:20:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20220316131723.111553-6-jefflexu@linux.alibaba.com>
References: <20220316131723.111553-6-jefflexu@linux.alibaba.com>
 <20220316131723.111553-1-jefflexu@linux.alibaba.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v5 05/22] cachefiles: notify user daemon when withdrawing
 cookie
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1030363.1647872428.1@warthog.procyon.org.uk>
Date: Mon, 21 Mar 2022 14:20:28 +0000
Message-ID: <1030364.1647872428@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
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
Cc: linux-erofs@lists.ozlabs.org, willy@infradead.org,
 linux-kernel@vger.kernel.org, dhowells@redhat.com, joseph.qi@linux.alibaba.com,
 linux-cachefs@redhat.com, gregkh@linuxfoundation.org,
 linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
 gerry@linux.alibaba.com, torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Jeffle Xu <jefflexu@linux.alibaba.com> wrote:

> Notify user daemon that cookie is going to be withdrawed, providing a

"withdrawn".

> +	/* CLOSE request doesn't look forward a reply */

I'm not sure what you mean.

David

