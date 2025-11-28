Return-Path: <linux-erofs+bounces-1444-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E36C9075F
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Nov 2025 01:59:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dHZgQ1sRtz2yvC;
	Fri, 28 Nov 2025 11:58:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764291538;
	cv=none; b=foPICVCfnQNXpTc9UWQJuwfKm9rFkmbS3JTKsUQU3x9jNY5RrbU/6CXki1yVV+GJPI5xD8qW0b4sw6tcz+SuPeEns7RMLLmdxCnaCng911Ia4IXgJ5Z8iDUqRyYM/ah1spnk6aocvpmjzgvW8Rc7GTk/prRhrqjxYGt+/YR5PDypBj+WESgSVaizKxhn/oiaZxCCpV2O/RpnhNFN5Mie1yOvNWCrQYL26QvUn4C3vfo4LehxQjSamHEMmF8lHqTXWPdZyOcKTqotKR8iLSVm32LPwB4zBm7wTx8EsWYdEaDH/TrNknTysPpe5Np+A59auQ7G8jf3aBZeB9PtJgZ/+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764291538; c=relaxed/relaxed;
	bh=tNt3E0n1VyBKP2kVKnfTr2ufXrlkrkWBA/fXZ8V+MOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuVdEQbuAZXvTQCFKi0hpR1aAfHk6ub9Obg0ml30pdnlwL1FX2Bqqctra+38DTVKHmlPR68qzFsYqutLPOgzahJLfLYhhV7HJlfgJ14ktItUAbGKMsV+oMrGhL1/H/BpYbjH9l6664sWed2CXgQwZ4T4dwbvwDOKk/XK9I4HTVoMX1xhDH4CV8mzp79BQOnak023q48sFk5KUVrFRvAeTldLgg4T9AmLCtBjOCCUTeEiB/7bNpyJvpaAGFXtEH8b0CMUA9G2QMoZR1KkdbsI3lKg1NaKFADobQwz7r0DqfpDD6T2BuxH5OcU+Quunxq8XCXarnwuA7QDkHZqnp/MaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YgJlh9kh; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ebyY677u; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=ming.lei@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YgJlh9kh;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ebyY677u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=ming.lei@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dHZgN5Ww8z2yFT
	for <linux-erofs@lists.ozlabs.org>; Fri, 28 Nov 2025 11:58:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764291529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tNt3E0n1VyBKP2kVKnfTr2ufXrlkrkWBA/fXZ8V+MOU=;
	b=YgJlh9khqOHPmAIOcU0yBeJVVHjXOHZZ66A4fnQhY21tpKqCPEw7xp+vPw3+2MrS3cEKPl
	7VBDncTR9vSGpT0WSoZ+WYukUizZ6EumR7wyguaci73vTpAQmWuwXE7AfrERHlSjRtpZ0H
	xdaSPQRhRGBC3PeXjbu7PrJAZQlnknI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764291530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tNt3E0n1VyBKP2kVKnfTr2ufXrlkrkWBA/fXZ8V+MOU=;
	b=ebyY677ufvpCBCXMpw1fEanPvSJvs8RPeoy7qyAirZNzYLGQvW8iKFsgHB8OEVHMCEaaf8
	8oue99YMAR1+ipTFG+ns5OqTNmnzNsMnrw0OJ4IfZMBaXXT6AHNbYYdbWdajOWFZmBCnC5
	D1IJMytcA4RCALgoanps/wIqi23ZN88=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-mek1DB1HNTOqvOGJdNgIMg-1; Thu,
 27 Nov 2025 19:58:45 -0500
X-MC-Unique: mek1DB1HNTOqvOGJdNgIMg-1
X-Mimecast-MFC-AGG-ID: mek1DB1HNTOqvOGJdNgIMg_1764291524
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B7531956089;
	Fri, 28 Nov 2025 00:58:44 +0000 (UTC)
Received: from fedora (unknown [10.72.116.171])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AEA7C195608E;
	Fri, 28 Nov 2025 00:58:39 +0000 (UTC)
Date: Fri, 28 Nov 2025 08:58:33 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Stephen Zhang <starzhangzsd@gmail.com>
Subject: Re: [PATCH v2] erofs: get rid of raw bi_end_io() usage
Message-ID: <aSjzua4jp_zZ1g1o@fedora>
References: <20251127080237.2589998-1-hsiangkao@linux.alibaba.com>
 <20251127080756.2602939-1-hsiangkao@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127080756.2602939-1-hsiangkao@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Thu, Nov 27, 2025 at 04:07:56PM +0800, Gao Xiang wrote:
> These BIOs are actually harmless in practice, as they are all pseudo
> BIOs and do not use advanced features like chaining.  Using the BIO
> interface is a more friendly and unified approach for both bdev and
> and file-backed I/Os.
> 
> Let's use bio_endio() instead.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> v2:
>  - call bio_endio() unconditionally in erofs_fileio_ki_complete().

bio_endio() can cover bio not submitted yet, so:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming


