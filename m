Return-Path: <linux-erofs+bounces-1409-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 802D0C6CD90
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Nov 2025 07:01:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dB9p13qkKz2xnh;
	Wed, 19 Nov 2025 17:00:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763532057;
	cv=none; b=CJ4OVTCR3ZVj+vfxNDdhLTk2b3CtH/LW6bzTCJxr2X7Qhe66ZvqXldiQRRaS68fPFUzOil2TCwM0s0BYF0z2RVl2S6Zq0Qd1gakdyyugH3rAIlJFBcWseTSRVnjbepgZInoQ1OGVwc2eEO3SRjIf3RJOS9OvBjr/lBey7Yg/hz4zRUfn/lLhwB9tw96J43CBsCF+XjHXXSlH6VY11wZZtU4KtCIIwEUf6sgBrvGZq/Qrl48rxzovzL7NXQNKI3KVsn52v+UeYAi7K8qAldgYFMyYfSOePQgFqhskBhAH5RsbGOGA1PW3cmAJXoeax9RD18F171lNaqBo2AXfVe8HhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763532057; c=relaxed/relaxed;
	bh=wo526rARRm+OOJkOvOMWW78YziTKANQUFagQnH8e+Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLx16ljpAKWZ9Kchm6ZstvOLvPx25m2Cb8z8/vWefzZ0mvat3MnJiwVCuC3Uj2woe67RJDr4WmJUEC5qShYh6s+OcQbKV9F0h1yOAZog9XxRq+BC35aXekBoYTmReQ+y6Jb325cDRaYljvVwrbuB7KiJetMnwGqaaq67BmhBmey0XlgyU7ruYyE6ebd0QOiGizZ4BbgBGfgAJkkKQKTzCJsi9e/5LHtoUd9j5kjk+7Xly52OD1tNAFkLtCBJJ2b4jdnP0cgJWVj3bjNk1OLd602VdpzH9FEmT5jaYxd+KYNwki95IKq0oFnuud/bK7wDh/6AvTlKfkDCyi4sDYFA6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 661 seconds by postgrey-1.37 at boromir; Wed, 19 Nov 2025 17:00:54 AEDT
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dB9ny75dwz2xS2
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Nov 2025 17:00:54 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8D6BE68AFE; Wed, 19 Nov 2025 06:49:46 +0100 (CET)
Date: Wed, 19 Nov 2025 06:49:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: brauner@kernel.org, djwong@kernel.org, Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Hongbo Li <lihongbo22@huawei.com>
Subject: Re: [PATCH v9 01/10] iomap: stash iomap read ctx in the private
 field of iomap_iter
Message-ID: <20251119054946.GA20142@lst.de>
References: <20251117132537.227116-1-lihongbo22@huawei.com> <20251117132537.227116-2-lihongbo22@huawei.com> <f3938037-1292-470d-aace-e5c620428a1d@linux.alibaba.com> <add21bbf-1359-4659-9518-bdb1ef34ea48@linux.alibaba.com>
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
In-Reply-To: <add21bbf-1359-4659-9518-bdb1ef34ea48@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Tue, Nov 18, 2025 at 03:35:45PM +0800, Gao Xiang wrote:
> (... try to add Christoph..)

What are you asking me for?


