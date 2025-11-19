Return-Path: <linux-erofs+bounces-1411-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EB9C6D9E1
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Nov 2025 10:13:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dBG3d6tmGz3brl;
	Wed, 19 Nov 2025 20:13:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763543581;
	cv=none; b=WImiUV+7CQ3OcdN8p4EbRh8tI8kFt8kzWeWlbzaNiNvTM1WFwVtAkhPj2LgYi0wE2YA014DWpbdS7xqwRvh+cxOj99Dv567dfw3GiE+zekz3+jQLhDmbcrA8gFekn/mmeZ2Cj9GMHoBVHanAYvkOrj3GJqAyCzUtb7bqSaYWjlaAe9CraEmirS3fjWD3DW3VPNZ30yCsj1HN4YVXxhrxSlOskwtOv/wPEdiE1cxNoq444vRfqJdMQkcG3LGs2qJDxu2e64R4fYYW3PkWCkteFYmvf4iWsQONyBHkIm/R1rIjt+tR+qI8wP8Qe5HgZeXdbVln3kU0jqyRJv3vpGDnVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763543581; c=relaxed/relaxed;
	bh=sYUr9Sb6uCeYEwz2KWbpI9yEyG7HXFbKWApRsrp971s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kk944CPQmYt62f7lzzQzGDZswnmX3Yq9Y9ghjVstOiHXOkv4UIxXmW7rPj7X4KablqHoa5caMu4A5fdDMkodIfE5LLNsRy1JRyyghGIh1LXM8LBr6ig1uDM+l5RYZz1whXl+RO5/SvcgRA+TQxU3GFl9mxqFVgdRtI8iVF0hkpOARhMFpkFxRo5yVBKd5Zq5ZEo+fg9X79ny2oINlzEmVMQ9mWB3xFOreXTNT3irI+lHYWaefgt7ozps8joQB+WwLwqiLpcNXJJ3SabjCcVAq3dtAZ/UKkjRm7LDIozEr0X8wJ9D3demXRzVpPVsPI5jaoH/PkF6U5uYitNYkKxwMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dBG3d2Lq6z3bpp
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Nov 2025 20:13:01 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 46EF8227A88; Wed, 19 Nov 2025 10:12:55 +0100 (CET)
Date: Wed, 19 Nov 2025 10:12:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, brauner@kernel.org, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Hongbo Li <lihongbo22@huawei.com>
Subject: Re: [PATCH v9 01/10] iomap: stash iomap read ctx in the private
 field of iomap_iter
Message-ID: <20251119091254.GA24902@lst.de>
References: <20251117132537.227116-1-lihongbo22@huawei.com> <20251117132537.227116-2-lihongbo22@huawei.com> <f3938037-1292-470d-aace-e5c620428a1d@linux.alibaba.com> <add21bbf-1359-4659-9518-bdb1ef34ea48@linux.alibaba.com> <20251119054946.GA20142@lst.de> <e572c851-fcbb-4814-b24e-5e0e2e67c732@linux.alibaba.com>
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
In-Reply-To: <e572c851-fcbb-4814-b24e-5e0e2e67c732@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Wed, Nov 19, 2025 at 02:17:07PM +0800, Gao Xiang wrote:
> Hongbo didn't Cc you on this thread (I think he just added
> recipients according to MAINTAINERS), but I know you played
> a key role in iomap development, so I think you should be
> in the loop about the iomap change too.
>
> Could you give some comments (maybe review) on this patch
> if possible?  My own opinion is that if the first two
> patches can be applied in the next cycle (6.19) (I understand
> it will be too late for the whole feature into 6.19) , it
> would be very helpful to us so at least the vfs iomap branch
> won't be coupled anymore if the first two patch can be landed
> in advance.

The patch itself looks fine.  But as Darrick said we really need
to get our house in order for the iomap branch so that it actually
works this close to the merge window.


