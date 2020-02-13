Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F9015CB3F
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Feb 2020 20:38:25 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48JRdB5525zDqVH
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Feb 2020 06:38:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=207.211.31.81;
 helo=us-smtp-delivery-1.mimecast.com; envelope-from=msnitzer@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=b9pE2Xrk; 
 dkim-atps=neutral
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48JRd63RpFzDqTT
 for <linux-erofs@lists.ozlabs.org>; Fri, 14 Feb 2020 06:38:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581622693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IwQHI79iQNnLF0R813K4ZfyJ/4oVZzBfHd4LqqijBNs=;
 b=b9pE2XrkADLdmoUXE5loiw60zI483fnL4xEntBVEP2HoE9X5iIx3f53SlD4pM0wtn3FDXt
 ZdQ8UiVWMcL+tqUqpD0b6zHOHtSkw24Byyqgx/1bxE5VgJFOKVJ1Gq1UozX38dCRYZ4RN+
 Ks+0BtUHooLUb+TilLvVOeWW6UwlZ70=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-2EOjsAokOgC2pnOKYZU8tQ-1; Thu, 13 Feb 2020 10:36:51 -0500
X-MC-Unique: 2EOjsAokOgC2pnOKYZU8tQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3280100550E;
 Thu, 13 Feb 2020 15:36:49 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A17CD5DA85;
 Thu, 13 Feb 2020 15:36:46 +0000 (UTC)
Date: Thu, 13 Feb 2020 10:36:45 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
Subject: Re: Remove WQ_CPU_INTENSIVE flag from unbound wq's
Message-ID: <20200213153645.GA11313@redhat.com>
References: <20200213141823.2174236-1-mplaneta@os.inf.tu-dresden.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213141823.2174236-1-mplaneta@os.inf.tu-dresden.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: Herbert Xu <herbert@gondor.apana.org.au>, dm-devel@redhat.com,
 linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
 Song Liu <song@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>,
 linux-crypto@vger.kernel.org, Gao Xiang <xiang@kernel.org>,
 linux-erofs@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>,
 Alasdair Kergon <agk@redhat.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Feb 13 2020 at  9:18am -0500,
Maksym Planeta <mplaneta@os.inf.tu-dresden.de> wrote:

> The documentation [1] says that WQ_CPU_INTENSIVE is "meaningless" for
> unbound wq. I remove this flag from places where unbound queue is
> allocated. This is supposed to improve code readability.
> 
> 1. https://www.kernel.org/doc/html/latest/core-api/workqueue.html#flags
> 
> Signed-off-by: Maksym Planeta <mplaneta@os.inf.tu-dresden.de>

What the Documentation says aside, have you cross referenced with the
code?  And/or have you done benchmarks to verify no changes?

Thanks,
Mike

