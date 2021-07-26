Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B843D5C99
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Jul 2021 17:07:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GYNZf1HB8z304d
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Jul 2021 01:07:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=sOAC1zyp;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=sOAC1zyp; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GYNZX03lRz304d
 for <linux-erofs@lists.ozlabs.org>; Tue, 27 Jul 2021 01:07:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=BubiKB9vB45J69umFp5in89rgduVxIwyz1cpJGxQFfY=; b=sOAC1zypeUA7rs8q0Zw+qXhU5q
 toYffRKhMe4o+N3uzGP7XKidnZnHdprBmR5GYoZC4KqwGWDLwdzLgBqWWsex3XzVCz9J/LXL6Hk+g
 7f7YOQx2/x4C7U45SOZXJ9zNXOJHo4Zgq3Yb1PjadyiE3aUINlZFqmNvQXIeMGtww/Iom++C2G5lJ
 Wf5Daib5UT5W/UfyiwpvAzHlXPwz20UuQye+MIRIcZo7yyEAP28itHHpnVKOd/jMKwtdsO4gxBs7j
 yDZ6g2hb83wVt9iDIbzJEtRXhB9x/Iqnc//TTRI/bnxFV0XHwjV1d0yU0ZQObcn+3U22e2rxfnv6k
 bVXKT5IQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1m82Br-00E4Pi-Rc; Mon, 26 Jul 2021 15:07:02 +0000
Date: Mon, 26 Jul 2021 16:06:47 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v8] iomap: make inline data support more flexible
Message-ID: <YP7Ph55kV0M8M1gW@casper.infradead.org>
References: <20210726145734.214295-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726145734.214295-1-hsiangkao@linux.alibaba.com>
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
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
 "Darrick J . Wong" <djwong@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


Please make the Subject: 'iomap: Support file tail packing' as there
are clearly a number of ways to make the inline data support more
flexible ;-)

Other than that:

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
