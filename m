Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B76BB4FBC0C
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Apr 2022 14:29:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KcSpJ5b9lz2ygB
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Apr 2022 22:29:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CP8kMLtB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CP8kMLtB;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=CP8kMLtB; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CP8kMLtB; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KcSpG2Q32z2xfP
 for <linux-erofs@lists.ozlabs.org>; Mon, 11 Apr 2022 22:29:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649680146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZZxI4JpPALM+cig/mNfvr19ofAGALyaSEU5a24joVus=;
 b=CP8kMLtBOANwyHrtTVK5JYBnIzolYx1TjZig50bcyL/JTddbC8SbkjC1UDjSgeaQADs5jb
 mlfCM04NqrqZMQoQ0J21gjcjsbTnhniepHt4AIwAZ6uTxYT3RmmyvbXhhE1B46pfIB2SEk
 M96eYdEXse2Mapi0MMYJwiqVFHL99p8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649680146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZZxI4JpPALM+cig/mNfvr19ofAGALyaSEU5a24joVus=;
 b=CP8kMLtBOANwyHrtTVK5JYBnIzolYx1TjZig50bcyL/JTddbC8SbkjC1UDjSgeaQADs5jb
 mlfCM04NqrqZMQoQ0J21gjcjsbTnhniepHt4AIwAZ6uTxYT3RmmyvbXhhE1B46pfIB2SEk
 M96eYdEXse2Mapi0MMYJwiqVFHL99p8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-cVdYnBS4P_6E-9tLZGI5oQ-1; Mon, 11 Apr 2022 08:29:01 -0400
X-MC-Unique: cVdYnBS4P_6E-9tLZGI5oQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5DB8C185A7A4;
 Mon, 11 Apr 2022 12:29:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B2EE741639E;
 Mon, 11 Apr 2022 12:28:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20220406075612.60298-4-jefflexu@linux.alibaba.com>
References: <20220406075612.60298-4-jefflexu@linux.alibaba.com>
 <20220406075612.60298-1-jefflexu@linux.alibaba.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v8 03/20] cachefiles: notify user daemon with anon_fd when
 looking up cookie
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1091117.1649680137.1@warthog.procyon.org.uk>
Date: Mon, 11 Apr 2022 13:28:57 +0100
Message-ID: <1091118.1649680137@warthog.procyon.org.uk>
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
Cc: tianzichen@kuaishou.com, linux-erofs@lists.ozlabs.org, fannaihao@baidu.com,
 willy@infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com,
 joseph.qi@linux.alibaba.com, linux-cachefs@redhat.com,
 gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
 luodaowen.backend@bytedance.com, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Jeffle Xu <jefflexu@linux.alibaba.com> wrote:

> +	  This permits on-demand read mode of cachefiles. In this mode, when
> +	  cache miss, the cachefiles backend instead of netfs, is responsible
> +          for fetching data, e.g. through user daemon.

That third line should probably begin with a tab as the other two line do.

> +static inline void cachefiles_flush_reqs(struct cachefiles_cache *cache)

If it's in a .c file, there's no need to mark it "inline".  The compiler will
inline it anyway if it decides it should.

> +#ifdef CONFIG_CACHEFILES_ONDEMAND
> +	cachefiles_flush_reqs(cache);
> +	xa_destroy(&cache->reqs);
> +#endif

If cachefiles_flush_reqs() is only used in this one place, the xa_destroy()
should possibly be moved into it.

David

