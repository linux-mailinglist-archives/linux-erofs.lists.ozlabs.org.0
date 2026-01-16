Return-Path: <linux-erofs+bounces-1963-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 524C8D334C0
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Jan 2026 16:47:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dt43S0cd4z2ySb;
	Sat, 17 Jan 2026 02:47:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768578420;
	cv=none; b=TCr8LFWpDhP7hYYezUF/rHe8pyQHS0qReolHZ9l6jXMcWDN92oawaBcdD3EceZbXNx/kUglr9IrPm6+tXMtTvKq3Wjbv+k9CYsWGs3UUoZpGbf9IZiGG6gcp9ZhX8CVAl9iEaWoYDzcO6Hald657E8N4didT+EyHiBLjn/nYY3GeGPvdM8iZSIfmWzjOOHqap8vVQIMMQv1d3sLoUyWPxE8CvSqbgyefxL5t54GwHNpMrDM13Q9V5AAQhaF2LUzSXDJJZWWYgepoe2ATFTxLvK9abYHT8N3FnMXQOWG77jrV8ILnmsW+TVKeYvRH4WIReZ5rzjQ94XIqL5Q1+pCbcg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768578420; c=relaxed/relaxed;
	bh=+hDKIqYFPSRdyW1LlELP1JEZZdFQu4u8Ncagr6+Gm3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/b6Z/5IMiAk4HczXWWXRwJ3rzH84O/hTeSz0RUepe8VeTbUSyiMYcixdfJzRjPN40mqwh78vLzKzWzG0rV/Ee0ProgsBUKZ+EFyrHtwq0/fSMIDf89NtU53U7KKojnGjvqmVj+t4UiX3+TJo+qcTZKEsFTMRv4+0VW/3Q5C3A1GkH7PmaPXwmhkdh5O0fj4M64/tAYcsVwxWXJmIJ1bOi/rKn9Nzqer3Fyy83F10WyNSQsmqbwx+B/radw85mLHg2oOFMcVku43f6gs4+pbBYdVKS6MWL/H6pPhVqTxC4jahdi/K1DweL/xIPTK1vHbcK3mb2JMcAz//w/D/CeY3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dt43R2j9kz2xnj
	for <linux-erofs@lists.ozlabs.org>; Sat, 17 Jan 2026 02:46:59 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 001B3227AA8; Fri, 16 Jan 2026 16:46:54 +0100 (CET)
Date: Fri, 16 Jan 2026 16:46:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: hsiangkao@linux.alibaba.com, chao@kernel.org, brauner@kernel.org,
	djwong@kernel.org, amir73il@gmail.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 9/9] erofs: implement .fadvise for page cache share
Message-ID: <20260116154654.GD21174@lst.de>
References: <20260116095550.627082-1-lihongbo22@huawei.com> <20260116095550.627082-10-lihongbo22@huawei.com>
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
In-Reply-To: <20260116095550.627082-10-lihongbo22@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Fri, Jan 16, 2026 at 09:55:50AM +0000, Hongbo Li wrote:
> +static int erofs_ishare_fadvise(struct file *file, loff_t offset,
> +				      loff_t len, int advice)
> +{
> +	return vfs_fadvise((struct file *)file->private_data,
> +			   offset, len, advice);

No need to cast a void pointer.


