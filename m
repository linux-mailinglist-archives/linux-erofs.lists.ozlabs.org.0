Return-Path: <linux-erofs+bounces-1983-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D53D39FC0
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 08:28:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvhrV6qS5z30Lv;
	Mon, 19 Jan 2026 18:28:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768807690;
	cv=none; b=LKUIRESRt04d/CtRmRlScPo8Kj7UWuVRt3r2jITRs+m6U41tK1u4mAHMOsCvSuy59SM1zOnpyOVJHS3Uh6P1SR5Oe9sJoNOtTs+foLY3JYMss5Fh1PaZahJ+Xtrc5hjJlp4BaC5q6R9A9uFBDCov+krz6ZudKmL4O5fgUKbaIl+/cDw4GnK2W1tweSG5uUE1XwRmiu0s/Tzkc6a3yu4CpEXbOUDC4TqZOybOr8zVVQlLprFN+8xBtwTHCo4oRJtc7T+lIFDNR8FJji1LBH1Q96k8v1FVDT7f/xX+tpNGJIObLDVkWQrEMuqdDZOzZnOZrDpFqR5G1zWMt5pudnuKvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768807690; c=relaxed/relaxed;
	bh=8JvuxRR/yGnaaAUNfVySnCpAUlFR+Mihv78tp0qn5aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPy3R2yhY6Ee23LGlWATkAi/+XlqPuo7sELCVXgZ+kRrvEoZ+nTMKTOX/en0GcARfhQtNIUEreGU9BMqMz6aBv27hTwXMTUp0B0oet0mhKTj4EiR41rqxkVErJNvLuQkkSeNXoLLyXNxOHI7WW1tgL4MEcBSO1lMTL/KvOOYK53fIf2VYBeFDuTSS60YXz+iZrY5CMYjwMJAkEw4mn4CQNEa4yhRp9z0HO+wzhBqgAxQEqYQWPfManXBaZXfqfxNqvIjJevmqtVx7U+AfH+nIns9jxQ+bZtLvps9zNP6BwIm+UYFW97nfTVwQHYKQg31IUVVAaZehCoUEd+Xl/8i9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvhrT51Fmz2yDk
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 Jan 2026 18:28:08 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 71D1E227A88; Mon, 19 Jan 2026 08:28:02 +0100 (CET)
Date: Mon, 19 Jan 2026 08:28:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org,
	djwong@kernel.org, amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v15 2/9] erofs: decouple `struct erofs_anon_fs_type`
Message-ID: <20260119072802.GA2562@lst.de>
References: <20260116095550.627082-1-lihongbo22@huawei.com> <20260116095550.627082-3-lihongbo22@huawei.com> <20260116153829.GB21174@lst.de> <c2f3f8bd-6319-4f5a-92cf-7717fa0c0972@huawei.com> <e4a45ea4-a0e9-4b8e-ab8b-b4dbb6a2ba21@linux.alibaba.com>
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
In-Reply-To: <e4a45ea4-a0e9-4b8e-ab8b-b4dbb6a2ba21@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Mon, Jan 19, 2026 at 09:44:59AM +0800, Gao Xiang wrote:
> But I'm not sure if there is a case as `#if defined() || defined()`,
> it seems it cannot be simply replaced with `#ifdef`.

They can't.  If you have multiple statements compined using operators
you need to use #if and defined().


