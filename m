Return-Path: <linux-erofs+bounces-1961-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6A0D333CE
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Jan 2026 16:38:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dt3sl42TLz2xm3;
	Sat, 17 Jan 2026 02:38:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768577915;
	cv=none; b=Nj99HueweVN+ySev9f/C2dZAWnhlFYqtlEHVtrDz8EnGLCjflBJIBPEUTmYwv5LbI5XOukSojh4w8hGAAQEfx71qUfw7oTTdAe5N+Nicl9nmPgtvu1uyeEBq8XueF/gTafSl2bBfMDqffZ1u19M2ZNpc+XtQUBfntW+Z1YQd6cHRdBBcPHRbToIXFmqaNMqYxGKQumev2CSYKjesfxYCQYNLV+XoyLt6F0U7h2Vr1VPrk8aOos65n4LA3IRj2FxkuFPxg4D2HuZDrrxOrGyqxeOOhXs+60KZNAubDT+8lbywbGEQBaJ5rd9vCp4X3Fs3rGVJt39TNWtBOFImTDAoaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768577915; c=relaxed/relaxed;
	bh=Nzs6x7QPR5GNcCNExIMK/JOS3Pv5Lx31mu3s0iXcI9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sk6wHXEWeF9dkn3hoXVChvjbVOTIObLmNUZm0tjIhMTdZRWlYltOHS1Df1SIrjY7HkC9KE95YMfL043dnXWsrMStN47DiWjmHvFbaizIvRoWXZ1UbkcflFtYU6acEAhbViTD4KLcfXkKugbqCNq6MlUd8DcTvesAdw1ZJlxj4Q9iXr4x9aVwG1ow2zGYiu8BvECLK4yQDulssTbt+0hDvYJnbFEKNzIZZSTM3zmsrwLJe6qxQ6Jh1flvBERfECSboQTa1Qc/9WFf7JoE4uhiXRnH0VXewze6futELmJjnSQIZ61TuBafaz0mu2C0UgCzterKaZK8PuFdbX3DQ+6r/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 88 seconds by postgrey-1.37 at boromir; Sat, 17 Jan 2026 02:38:34 AEDT
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dt3sk214bz2xS2
	for <linux-erofs@lists.ozlabs.org>; Sat, 17 Jan 2026 02:38:34 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 43D60227AAE; Fri, 16 Jan 2026 16:38:30 +0100 (CET)
Date: Fri, 16 Jan 2026 16:38:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: hsiangkao@linux.alibaba.com, chao@kernel.org, brauner@kernel.org,
	djwong@kernel.org, amir73il@gmail.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 2/9] erofs: decouple `struct erofs_anon_fs_type`
Message-ID: <20260116153829.GB21174@lst.de>
References: <20260116095550.627082-1-lihongbo22@huawei.com> <20260116095550.627082-3-lihongbo22@huawei.com>
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
In-Reply-To: <20260116095550.627082-3-lihongbo22@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

> +#if defined(CONFIG_EROFS_FS_ONDEMAND)

Normally this would just use #ifdef.


