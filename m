Return-Path: <linux-erofs+bounces-1962-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB17D334AA
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Jan 2026 16:46:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dt42t69w3z2xm3;
	Sat, 17 Jan 2026 02:46:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768578390;
	cv=none; b=VtDlS5K4RI82zURxhKaXISgtN0IDDDseMDlT9nFsHOBo5zbJNNkiIRtnTWkwEaGGhsTTp/F4cHhnXCoiWa00RtI+9UtsR1z3XoY5yTow6vPfNFc85InjR8DM1uMJrXwZ/SOUy+GACRgm7Fgj3LsSfCjsX70n3wUGMDGMYbxuusdJsYYNEsOQdD0ByifdgO7ZbIMkVuQRrWFjFlkWpK7snJa1WiwXqxsy11ewvBrkbtxqNLUFV2D9f6Zwf+vKIky4uzljzKASXgB2GIJ3wDC7i53P9m9gkKgODtDej+z/RgBOilV8cPaIX7PSscWQC99NkepK2XFnNXq1+F4gDeJIbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768578390; c=relaxed/relaxed;
	bh=JFSnqvRpA3Fgfljd3s4RgwaeTeBel7Es5UBliNLHL3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPO+XEFyBjkg/aIiTE9fX8hX4Hkm3Yd3DxHMjOgwrYCM7M3XvgaQXJLEYA9qkbfPA5gm4vJs0odRLkO5a6IJSQeY8jVKQtcZdmLNpw04j7A13c3ahqpeUksSUQC3cgtXDPUxlHFtn6oPcy7FLMFSrRNOOXJo+5gB9YlblurvQAkqOl1q/vrcyfDRhSkcAtwODrVeM+unRasER0RLCWf/k1KbJWCbzci9qtXOSgg27GUp4q11NYoSlPRhw/lh6XrC7ji2cdpOwDATbPokRiBtHI6GW/txlmyvVYT978Tfa+ZNh52S2wzPyfEJwW98SXQeYdHFHs7sBDl0qxs6mMeN+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dt42t0wfNz2xS2
	for <linux-erofs@lists.ozlabs.org>; Sat, 17 Jan 2026 02:46:30 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id E123B227AA8; Fri, 16 Jan 2026 16:46:23 +0100 (CET)
Date: Fri, 16 Jan 2026 16:46:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: hsiangkao@linux.alibaba.com, chao@kernel.org, brauner@kernel.org,
	djwong@kernel.org, amir73il@gmail.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 5/9] erofs: introduce the page cache share feature
Message-ID: <20260116154623.GC21174@lst.de>
References: <20260116095550.627082-1-lihongbo22@huawei.com> <20260116095550.627082-6-lihongbo22@huawei.com>
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
In-Reply-To: <20260116095550.627082-6-lihongbo22@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

I don't really understand the fingerprint idea.  Files with the
same content will point to the same physical disk blocks, so that
should be a much better indicator than a finger print?  Also how does
the fingerprint guarantee uniqueness?  Is it a cryptographically
secure hash?  In here it just seems like an opaque blob.

> +static inline int erofs_inode_set_aops(struct inode *inode,
> +				       struct inode *realinode, bool no_fscache)

Factoring this out first would be a nice little prep patch.
Also it would probably be much cleaner using IS_ENABLED.

> +static int erofs_ishare_file_open(struct inode *inode, struct file *file)
> +{
> +	struct inode *sharedinode = EROFS_I(inode)->sharedinode;

Ok, it looks like this allocates a separate backing file and inode.


