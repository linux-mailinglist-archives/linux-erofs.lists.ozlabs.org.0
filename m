Return-Path: <linux-erofs+bounces-90-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 56482A686A5
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Mar 2025 09:23:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZHhYb6KLyz2yf3;
	Wed, 19 Mar 2025 19:23:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742372611;
	cv=none; b=kW8ol3zoR+BhUhrNu7lVRWKt3+/NAq5Db0UfibBguCkpPFVWYvG4S+gM5FyF4TCHdVJzJzMB4oOHBID8l+3lUdMIwiykoI2WLsDsDkfZZcVfO2CM2J+criXbtpbZo0ArbtpJkfSCM2TSmhde6jiRjingPeb107osidjenEczuRx/EFp9w/mJYrr0WwGwOc/MMl/ufjYl8Jjt9d+LtA4GDHlToUac/2WLS5h9T2+7MuaaOKPQIgGc8iXIVyMzUpRTk8yCvSFUn+XluuqcBjnv3cZn+KIXguS9FdRTFJsexWcEfS5VAQDfIzCMK4DjgC7fKnDlLsncMKxk7eLDPcagYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742372611; c=relaxed/relaxed;
	bh=0/NLEQoCebraxtq1JzompQ/FgivdDVzPYEt3oma6mtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6BkTjbvJxyiVufHF/FI1K4iQ0vJmR7RWmVetNZDlbDw5x1LiRVgRE2sauULZIPST6gXESc6AouajtsrKmabzEQF8JsSPqIGYsG+MV3O0Ml3lNsEa8muGPZizK3SBvdPClFNbNRqWXgBGiowNkH8wCiWV9E0gUV6kmqkVRXfBGDAniy2JXjxfPgvqHp7k3hgtg4KGH4D9f6i6MtI3DggieZpiwOph3vix18k5op1XvtDIEkBgwQxlX/8gZDWYTSk3elOqPJ8y0TO+8mtf2rZ0S2dKcbGCXNhgdaqETo1JAnFPNAGW7gKNt51P+Zg5H/NB4yHmae90AdOnfVOGZcpAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZHhYb16g5z2ySb
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Mar 2025 19:23:31 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1FA4A67373; Wed, 19 Mar 2025 09:23:24 +0100 (CET)
Date: Wed, 19 Mar 2025 09:23:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Brian Foster <bfoster@redhat.com>, linux-erofs@lists.ozlabs.org,
	linux-xfs@vger.kernel.org, Bo Liu <liubo03@inspur.com>,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH -next] iomap: fix inline data on buffered read
Message-ID: <20250319082323.GA26665@lst.de>
References: <20250319025953.3559299-1-hsiangkao@linux.alibaba.com> <20250319081730.GB26281@lst.de>
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
In-Reply-To: <20250319081730.GB26281@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Wed, Mar 19, 2025 at 09:17:30AM +0100, Christoph Hellwig wrote:
> I'd move the iomap_iter_advance into iomap_read_inline_data, just like
> we've pushed it down as far as possible elsewhere, e.g. something like
> the patch below.  Although with that having size and length puzzles
> me a bit, so maybe someone more familar with the code could figure
> out why we need both, how they can be different and either document
> or eliminate that.

... and this doesn't even compile because it breaks write_begin.
So we'll need to keep it in the caller, but maybe without the
goto and just do the plain advance on length?


