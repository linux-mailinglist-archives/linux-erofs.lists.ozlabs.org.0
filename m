Return-Path: <linux-erofs+bounces-87-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322CDA68524
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Mar 2025 07:38:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZHfDW3kywz2yf3;
	Wed, 19 Mar 2025 17:38:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742366315;
	cv=none; b=QlhJQNm+oXOFLonm2N0tK9hswUSDuI3iopb5TcmZrvWM2cOrEyI8NKLCWgzKF8rrPYP8ysg992IV1VcPHqpYc5rA5Wn7X9hoUOYQLQqiM7ouJ1uhkHW7+6GJSbuQjr6ndWfQd/hFDgk649zgaQRjmwPnpVliWbxBGohIbCjSUu3+2T1rQCbzKh7Dmsx5EbNmEngGnGOzwUcTvAdw/QBY4Qhk5zQsZBgV3miCcq7DqvBj/5DKlL4mWrh41YxA+CizqbzPA6BB4YBEATrgz5oBqt4QoprFDMTR1z5lusiNXkUm/qdennbvH17o+9YruvA977YgpXczzX+0rtmRJNYG/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742366315; c=relaxed/relaxed;
	bh=IIMGo8sm/a3iFodn9ekFI0Udc15SNFtMglcWAu9rGPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQbfEZWo2t8r+XmJWomlvtrhdMlILyaBWwrZkn+apRVXSB6/IhU+guaj/8dOiP6fi4DjN4Gi6O8H75mIwmMLxevUtqBuNfl9X7z4qSckLplkOoO2tG6l/9MxO5es08qZbA46uo1TXAPQJvmLEpkftSiwZko4jJ+9O8i/XXRUN8hqpNxoaZPnAqBVAKcurJdePPWXrPBAbMB6tnTQ6Q+BAWmCcPIzcumCQJnLXRD7MhhXeXNG0JeVFkoWb5TsF84knw6BD/KHIFf//IKtwLPAnAdz/n9aZEGg5RUt0b4PfeFq+ZiYCjt0g3dEwTX4bOMgsVNdilz0518r9kD0G7GTjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 542 seconds by postgrey-1.37 at boromir; Wed, 19 Mar 2025 17:38:34 AEDT
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZHfDV3QRkz2yb9
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Mar 2025 17:38:34 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7E20F68BFE; Wed, 19 Mar 2025 07:29:23 +0100 (CET)
Date: Wed, 19 Mar 2025 07:29:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 3/8] lockref: use bool for false/true returns
Message-ID: <20250319062923.GA23686@lst.de>
References: <20250115094702.504610-1-hch@lst.de> <20250115094702.504610-4-hch@lst.de> <ptwb6urnzbov545jsndxa4d324ezvor5vutbcev64dwauibwaj@kammuj4pbi45> <CAGudoHEW=MmNLQSnvZ3MJy0KAnGuKKNGevOccd2LdiuUWcb0Yg@mail.gmail.com>
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
In-Reply-To: <CAGudoHEW=MmNLQSnvZ3MJy0KAnGuKKNGevOccd2LdiuUWcb0Yg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Tue, Mar 18, 2025 at 04:51:27PM +0100, Mateusz Guzik wrote:
> fwiw I confirmed clang does *not* have the problem, I don't know about gcc 14.
> 
> Maybe I'll get around to testing it, but first I'm gonna need to carve
> out the custom asm into a standalone testcase.
> 
> Regardless, 13 suffering the problem is imo a good enough reason to
> whack the change.

Reverting a change because a specific compiler generates sligtly worse
code without even showing it has any real life impact feels like I'm
missing something important.


