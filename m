Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 530733BC359
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Jul 2021 22:16:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GJcQK0ww2z305p
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Jul 2021 06:16:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=D1zngPFj;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GJcQ54jkQz2yxq
 for <linux-erofs@lists.ozlabs.org>; Tue,  6 Jul 2021 06:15:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=cHJoMBPoqsS6VIVZNAuTsCESFJ7feq3dFA9cLcq4xmA=; b=D1zngPFjaraCLiltD0U9yxBX5A
 kIMC9/R+DfJbPFWbxRozfUqe9136feg/Kr6BoNXvWvtm/XIW9SwZy3izXGiMYCgWX+Ym70KenbpQe
 ezSvZvnaCC45B/8btVNs0RScJA+xPsaH6ZVm//YELSSSRsIGiF/n9SEIf64hLzXAtyhalxU1R49UP
 APxCJJwB0JQTQbNK9VuINLaYN0QwlCF3ghVn6R29hMefxMlqdcbOhE9Xc/XZ37+y+6n/GVaUfnOog
 ZzedbwMTrw5xZZIGrhjzjZrDMftyygVn/lfgKTBG1X6Yo/v6gs0hubZQs35II+taREN02/LF6NSzi
 F03mz0wQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1m0V02-00AZ6w-Fs; Mon, 05 Jul 2021 20:15:36 +0000
Date: Mon, 5 Jul 2021 21:15:26 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Gao Xiang <xiang@kernel.org>
Subject: Re: [RFC PATCH 2/2] erofs: directly traverse pages in
 z_erofs_readahead()
Message-ID: <YONoXm1ksYgWWi/r@casper.infradead.org>
References: <20210705183253.14833-1-xiang@kernel.org>
 <20210705183253.14833-2-xiang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705183253.14833-2-xiang@kernel.org>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Jul 06, 2021 at 02:32:53AM +0800, Gao Xiang wrote:
> In that way, pages can be accessed directly with xarray.

I didn't mean "open code readahead_page()".  I meant "Wouldn't it be
great if z_erofs_do_read_page() used readahead_expand() in order to
allocate the extra pages in the extents that cover the start and end of
the requested chunk".  That way the pages would already be in the page
cache for subsequent reads.

