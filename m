Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A742C60F8C1
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Oct 2022 15:13:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MymMq2xbGz3c6D
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Oct 2022 00:13:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TXTFdeep;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Kk+JJiSD;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TXTFdeep;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Kk+JJiSD;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MymMl2P9hz2xgG
	for <linux-erofs@lists.ozlabs.org>; Fri, 28 Oct 2022 00:13:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1666876416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dQxbSjhqzSOLM0ahZEXNwS5QfLD56iw/ahD7kkiNphg=;
	b=TXTFdeepwgD9eyE+i5og5DV7CrYv8CVzs3XKl01RopMu4dFbDgNYdMhiR9dqDQsSa6OA5u
	qDGvpSWtwvGtGNRY7HA2q+8ytpMvj16At3fGW/FLW+EqN4EFfltwiYqtVooeZBfYFLxW/w
	LyzEyTIL0qUZB8t+BAjdf4JRpihPbT4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1666876417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dQxbSjhqzSOLM0ahZEXNwS5QfLD56iw/ahD7kkiNphg=;
	b=Kk+JJiSDsTx3hx3H92HVnIZuSNEEwDXSmAlCqjjdAdtb5OS6QgNgtCv5sVHwBrHuIJYU6O
	/FA+uxc6+OSubhZeO2gqUl36dLs1S85zXMEaGQAZQCOqn4AOUyoY+HhAt3vqSDQDTJeaTt
	wfHEhd1XbcmwPxEErWBAV3CFVsqkEJs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-214-IoArZIJpNemIDmIp9PCBzA-1; Thu, 27 Oct 2022 09:13:34 -0400
X-MC-Unique: IoArZIJpNemIDmIp9PCBzA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3415F3C0ED55;
	Thu, 27 Oct 2022 13:13:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.73])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 97E181415117;
	Thu, 27 Oct 2022 13:13:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20221027083547.46933-10-jefflexu@linux.alibaba.com>
References: <20221027083547.46933-10-jefflexu@linux.alibaba.com> <20221027083547.46933-1-jefflexu@linux.alibaba.com>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH 9/9] fscache,netfs: move "fscache_" prefixed structures to fscache.h
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3306695.1666876383.1@warthog.procyon.org.uk>
Date: Thu, 27 Oct 2022 14:13:03 +0100
Message-ID: <3306696.1666876383@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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
Cc: linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, jlayton@kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index 2ad4e1e88106..1977f953633a 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -16,19 +16,10 @@
>  
>  #include <linux/workqueue.h>
>  #include <linux/fs.h>
> +#include <linux/fscache.h>

Please don't do that.  fscache is based on netfslib, not the other way around.

If anything, I'm tempted to move fscache into netfslib.

David

