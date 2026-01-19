Return-Path: <linux-erofs+bounces-1989-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F58D3A1AC
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 09:33:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvkHK049wz2xSZ;
	Mon, 19 Jan 2026 19:33:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768811580;
	cv=none; b=fkkMSs6Afp6ghBr3t78Qb8cv8Pw69DDQxM2lCHYEQ1RkoeEPH4OCZZQlqsnNUU/fDzF3SVP6QZW4Ti+iirP7fEmTxXalY8FxdiuxTyKkeRuONhxC0Uce/kTxu5ZDaVWQz+sDx2COQVqL4r8F+4ZUX8nWTUcM4uCcL2WM/ZJh+Fv95bqSdqCqwhP5sPyKvDZrd2r/ueZvCWgrhYhRgImqqdgYfWXQSc3PsnUQKv7I0One4HhXatR2yjO5br0LB4+8P9YkS/hnCSfuO0naOyb7Jd3ibtFlBpaN8yc85CHDN/+pjl7kvlzU5AoTbFgT93D4P3S4QoR7SxFA7iQdHxARiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768811580; c=relaxed/relaxed;
	bh=MNZ5LOr7GkOIT5W+2C8KsXHHA4vCw5QsCjg0yyO57B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eg1eifKQq8fMVLv3lHyLzu1EmxK51mPZ09Ab/uIjDRlGr1egvr/W8SZSPv/VYk1VEaF52+niaZSvAZsssRIIKcGW974SfWJN3/Pob5b7XQqP0OO9vKa4S2pYlTeKSDNJAbmGx51eWCNFAWI/aRRTprNWYnKzyhm2Y+h8mklApKzguD83KAnavSDaDunksr+ivOGcFkMF5uzQk0bkALldz3vhOeJqJ5elyrnqxFuQH8YSE01zzKTq8zFfAaMLOT1Hxpm01DbDK/3V+jXUJLUf2jYWT4LJhByDoCZc+jjBwTKRa35SdLIG75B7cp0MbRU3wraTW7aNGvfiz39XsPdo4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvkHJ02t1z2xHW
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 Jan 2026 19:32:58 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id F41E4227A88; Mon, 19 Jan 2026 09:32:51 +0100 (CET)
Date: Mon, 19 Jan 2026 09:32:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Hongbo Li <lihongbo22@huawei.com>,
	chao@kernel.org, brauner@kernel.org, djwong@kernel.org,
	amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 5/9] erofs: introduce the page cache share feature
Message-ID: <20260119083251.GA5257@lst.de>
References: <20260116095550.627082-1-lihongbo22@huawei.com> <20260116095550.627082-6-lihongbo22@huawei.com> <20260116154623.GC21174@lst.de> <af1f3ff6-a163-4515-92bf-44c9cf6c92f3@linux.alibaba.com> <20260119072932.GB2562@lst.de> <8e30bc4b-c97f-4ab2-a7ce-27f399ae7462@linux.alibaba.com>
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
In-Reply-To: <8e30bc4b-c97f-4ab2-a7ce-27f399ae7462@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Mon, Jan 19, 2026 at 03:53:21PM +0800, Gao Xiang wrote:
> I just tried to say EROFS doesn't limit what's
> the real meaning of `fingerprint` (they can be serialized
> integer numbers for example defined by a specific image
> publisher, or a specific secure hash.  Currently,
> "mkfs.erofs" will generate sha256 for each files), but
> left them to the image builders:

To me this sounds pretty scary, as we have code in the kernel's trust
domain that heavily depends on arbitrary userspace policy decisions.

Similarly the sharing of blocks between different file system
instances opens a lot of questions about trust boundaries and life
time rules.  I don't really have good answers, but writing up the
lifetime and threat models would really help.

