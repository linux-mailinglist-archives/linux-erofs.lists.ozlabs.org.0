Return-Path: <linux-erofs+bounces-158-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 89531A7F83C
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Apr 2025 10:46:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZX0761TjCz2yyT;
	Tue,  8 Apr 2025 18:46:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744102002;
	cv=none; b=VbaNGQChZykbB0/bHoNyQm+pXQUhKMimZOir6bZpAG71xvKcRaBFSzSX4QFUHB0Dxw3jMsCv4azXjYwG/pk9Hb85szA3nMvYmQQQKWsoozIc1EApvtWsD1Y29cplpn1rlO/PV0lSmxQWdZfSZ4RkJzvNpHavEut6f0UC5vZQpWsSfDtzO1yde/igeistW/mEGsDYbdj2WEIm8+P/Ea1yCaFg1bR0cjFVZwGUer4XIyki3GTF16gVmchT4+Wy/TBjOONZEr9mqz4b855tcUgXYuJmZVfzE0TTuMvp7A0S+NyAyAlBo+aRY43FdQRt3WP0FAbRIroIG9Xswx1pXlsTag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744102002; c=relaxed/relaxed;
	bh=TG5DMStY3ZVURXCJczyNhF/JQw67BLGSt3SBnSQ+h7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6MbQ2vG0fu016SPwR0yM+os0xbOAfpmYV3ukjymNSGD7dQG7omn5FFjbsfzPcdDQAux2yOQnOAPX4RcPrS9teHPHtrfL1uYi4ywobP4WgenhXj8WcF6zkv5+6cwoDuSVQQD8vnPXi2eJ5ryA22NE+fcXOJFFEaczCNyeu1sMqTSubAK2NZ8Arfy3n1sjmmVcnaz98jojRSW71O43Zh2HzeMHwzRJbMkekfG5zBbKQeoL826PChvNRBl1I675IvXrotP1jX5Xqa8OmbE2yRMmF00EX1X9M+wcTnj9lNYorNtw6OjbYjmVKzDwTW87j75O0eDWRpNM37DAiqIGFhqRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XSnhe9UG; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XSnhe9UG; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=kzak@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XSnhe9UG;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XSnhe9UG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=kzak@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZX0750RLrz2yy9
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Apr 2025 18:46:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744101997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TG5DMStY3ZVURXCJczyNhF/JQw67BLGSt3SBnSQ+h7E=;
	b=XSnhe9UGprYCJz0EHiABCbKQLuTA/MZpc9WTEoLtnxUOdvwqx1LE0cUGbFYmABacDkdWX0
	9Kf88de6OqQ2dTvi4nwzxIry7Y0jJpXEOFBTJab/SAO/P2iVDT6L0bTX5/zNrTH/TgfNAv
	fyFtuADxV4GWatmXp/KGnbhKJVw7FcI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744101997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TG5DMStY3ZVURXCJczyNhF/JQw67BLGSt3SBnSQ+h7E=;
	b=XSnhe9UGprYCJz0EHiABCbKQLuTA/MZpc9WTEoLtnxUOdvwqx1LE0cUGbFYmABacDkdWX0
	9Kf88de6OqQ2dTvi4nwzxIry7Y0jJpXEOFBTJab/SAO/P2iVDT6L0bTX5/zNrTH/TgfNAv
	fyFtuADxV4GWatmXp/KGnbhKJVw7FcI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-o7R7vcNUOIWYCKBAwq3gyA-1; Tue,
 08 Apr 2025 04:46:31 -0400
X-MC-Unique: o7R7vcNUOIWYCKBAwq3gyA-1
X-Mimecast-MFC-AGG-ID: o7R7vcNUOIWYCKBAwq3gyA_1744101989
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E29661955DDE;
	Tue,  8 Apr 2025 08:46:28 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.198])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 93E3D180B48E;
	Tue,  8 Apr 2025 08:46:25 +0000 (UTC)
Date: Tue, 8 Apr 2025 10:46:22 +0200
From: Karel Zak <kzak@redhat.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Sheng Yong <shengyong2021@gmail.com>, xiang@kernel.org, 
	chao@kernel.org, zbestahu@gmail.com, jefflexu@linux.alibaba.com, 
	dhavale@google.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Sheng Yong <shengyong1@xiaomi.com>, Wang Shuai <wangshuai12@xiaomi.com>
Subject: Re: [PATCH v3 2/2] erofs: add 'offset' mount option for file-backed
 & bdev-based mounts
Message-ID: <gk7jzl7pktrdpznqp2hiuflx56xyttw4v4z3epia2ziw4oz547@cft7fyeoirfr>
References: <20250407110551.1538457-1-shengyong1@xiaomi.com>
 <20250407110551.1538457-2-shengyong1@xiaomi.com>
 <7nupludayogog6jylmwnxwel4zlvfxeozzcg5qkf5g5a5fpt7g@3bgvpbqfuxxa>
 <d4eae031-8fbb-45e2-bdf4-f3a8a034b8ad@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4eae031-8fbb-45e2-bdf4-f3a8a034b8ad@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Mon, Apr 07, 2025 at 11:49:31PM +0800, Gao Xiang wrote:
> On 2025/4/7 19:40, Karel Zak wrote:
> > We can improve it in libmount and add any if-erofs hack there, but my
> > suggestion is to select a better name for the mount option. For
> > example, erofsoff=, erostart=, fsoffset=, start=, or similar.
> 
> Thanks for your suggestion!
> 
> it's somewhat weird to use erofsprefix here, I think fsoffset
> may be fine.

Yes, fsoffset sounds good. I anticipate more filesystems will support
file-backed mounts in the future, making this option reusable.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


