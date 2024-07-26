Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE1693D11E
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jul 2024 12:27:43 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MwSMSxLY;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WVkTk2gTPz3dHM
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jul 2024 20:27:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MwSMSxLY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WVkTf4jWxz3d9s
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Jul 2024 20:27:34 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 14DBECE0B11;
	Fri, 26 Jul 2024 10:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAAFC4AF07;
	Fri, 26 Jul 2024 10:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721989652;
	bh=gqS+bnHGN3PI1lQgIphwTZ959H8S8VAnVlC3KPa2a3o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MwSMSxLYfCL4rlH6vxbnbqPKhxQFS9MesvJF+JIuRjE46O3m43gXAzzIvA8Ded27F
	 L0+VdGj807p1jI5By7jehYJbNFlkxv61q7DuveVya5YD18Utrf70CWLyNFVlKPiVdA
	 paq3CBxatc4aQBqLSXJUHFeTw3ua7CzXBZ8VDVG+ch//ZmvDXJdjwt6x5/Iu8+33qG
	 QATc+Bpr2Jr7tkmohgVkO1Sy3bpHTuKFYuVjzyMTok+ZvGuN5l5WqN+DJUn8DF+prz
	 110VQ0q3H7fy3ZX7emEV79WWSct73PNCaMZq1EKZBMHj3c19QBs2PnMRqXwWQFyCP9
	 9jbBKUUh9dVJg==
Message-ID: <68d18ae4-88ca-49fd-b105-85eb3f48715b@kernel.org>
Date: Fri, 26 Jul 2024 18:27:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: support multi-page folios for erofs_bread()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240723073024.875290-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240723073024.875290-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/7/23 15:30, Gao Xiang wrote:
> If the requested page is part of the previous multi-page folio, there
> is no need to call read_mapping_folio() again.
> 
> Also, get rid of the remaining one of page->index [1] in our codebase.
> 
> [1] https://lore.kernel.org/r/Zp8fgUSIBGQ1TN0D@casper.infradead.org
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
