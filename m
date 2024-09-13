Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BC625978506
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Sep 2024 17:39:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726241968;
	bh=dkq/CgCtZzCcTH1onWSQbfYvWKTTNcfQ+ZIxOlfRdyA=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=QjUIFQfQmhAK3RPvz/Ge1GqfJmgUSbQfXHRo0doYBEjp662ZOX4SfkPHrDk+Fgdla
	 b6joG3jryeWX9NMJjTgyIu3r+sx4mo5u0RITFqPoADi0Ys/QJHAg+fnhRxETZJXd/+
	 6exlIkRsfpz/dVRRcswlGwvTUpciO33Wu0+MLmJope0s8XUA9txUPxBHackJc27/we
	 njd1on91dd2PkFMCRXlMtOexhivtk2b1GBQkINvaEjoRE9251hp00M4BizoIJLh2yo
	 962bbuoQ0RNW6qvRfYEv+Dh+B5B+eLK8RTY/aS8WVLVLEnAj4TxROcxZbHKv3H1IE1
	 s4ZoFLf2PnRXQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X4z4w4n28z301v
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Sep 2024 01:39:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726241965;
	cv=none; b=FrQ7iKrH/voLXLfvs6nQGN8Uz12z1SOmknalfO/niQq87P4LWcS5nkmGVDJd8U45SB0s43N/0Tqai8Xo75+Ik5vfAWxULvvom0My/ORjw85uTvurTZxHvzb7ipfxIcnFoe4IOnknzgsRup3FI+rkrlCOvujyW6ayZC1+07rriG3gvH70kfladWxYkj/YsdzMxI3FogutnD9sQNeHIUP31ldox+hWciqVvok8jCYtfMNsqtJdUHMNajalFIRJMcCoC0Nrj3Bczp1ZqCLjzc8I7vgY/y7khO5zZ/Q3d8apDSO/cXfAYaN1ZIzLPUnyqxTjDQyN37zkf1tPExkFYVbZbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726241965; c=relaxed/relaxed;
	bh=dkq/CgCtZzCcTH1onWSQbfYvWKTTNcfQ+ZIxOlfRdyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsoqUVhkXXckPzmaybRzQol6WHiC6/iGXEJVZQyxYnu4N0TD6Sx3/86Kixu4eidhaLlEeA7EL9ZYCOkbM7rIGytp2tjNj+qhg6bpthr+gH14HqjOPbE8G0k+UNYhKBU8rg5lxl4Mkd/iB9qK2rSdKTDfcq4Ln1Wf4bqWYjsYljVNpMH0/79hUDGjR0y84WfmTfPAI9V14Jn/2wpHRgaVvcj5cSJI9T7g8EaxuTNheQA/n5XAr8QkeDVHU8EHF4X35xPW3LqR2SjZIMDJkreljUbuEX3RrWj8zZn2hmRYu/Do7uTNthkEHjchgyDL7l7ZmsNMoxMTTolHGo/l/OdKhw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nhoo6Ll+; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nhoo6Ll+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X4z4s45GWz2yYK
	for <linux-erofs@lists.ozlabs.org>; Sat, 14 Sep 2024 01:39:25 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 964D5A454D2;
	Fri, 13 Sep 2024 15:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED195C4CEC0;
	Fri, 13 Sep 2024 15:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726241960;
	bh=rn4Ve9iMrr+gD+OsNUnsEKUzUgTe+HP2eS/MJkYSjZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nhoo6Ll+j/YXDJLv6v6bbClyzih8aBkVYg9p2au88VnnocDfHg9+P4aCYS8Frmeou
	 SEC7EJ4aVe4vmQi9DLdZJLegoVk8kFvUHWJCISifljbxq4i6YWGXgF/EwVjXQb4IHt
	 PXC7Vk4Z07kE97p8/NzoEJVi4Tq+GQ+nEs69ozxBS13sXsD1kU9X/Q3Rs7LXXO+R9E
	 gHFSfGoTrsA8Tgn6zBHX84VAW7oM02BbSb+ZhsWohAuEetXI/uLvLrXP4+hpktQ2vO
	 RuMg2yelASY4LJ0agUClS3Yua+OG3il4UTFHRER0+FKNRsn0Hem/Xl4gVOa4CeXSqd
	 aeYU4yhOmXHhg==
Date: Fri, 13 Sep 2024 23:39:14 +0800
To: Sheng Yong <shengyong@oppo.com>
Subject: Re: [PATCH] erofs-utils: lib: fix sorting shared xattrs
Message-ID: <ZuRcogZoSD2/QiCm@debian>
Mail-Followup-To: Sheng Yong <shengyong@oppo.com>,
	hsiangkao@linux.alibaba.com, chao@kernel.org,
	linux-erofs@lists.ozlabs.org
References: <20240913143542.3265071-1-shengyong@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240913143542.3265071-1-shengyong@oppo.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <xiang@kernel.org>
Cc: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yong,

On Fri, Sep 13, 2024 at 10:35:42PM +0800, Sheng Yong via Linux-erofs wrote:
> The length of xattr_item->kvbuf is calculated by EROFS_XATTR_KVSIZE,
> and the key part has a trailing '\0' before the value part. When qsort
> compares two xattr_items, the key-value length should be calculated by
> EROFS_XATTR_KVSIZE, and use memcmp instead of strncmp to avoid key-value
> string being cut by '\0'.
> 
> Fixes: 5df285cf405d ("erofs-utils: lib: refactor extended attribute name prefixes")
> Signed-off-by: Sheng Yong <shengyong@oppo.com>

Yeah, good catch! And many thanks for fixing this!
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
