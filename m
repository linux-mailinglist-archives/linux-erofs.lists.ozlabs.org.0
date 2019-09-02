Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB70A56A3
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2019 14:50:10 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46MVKp4FY6zDqTn
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2019 22:50:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+8d7e6b8ef813b711cfc0+5853+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="UFTnfwfJ"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46MVG51JhpzDqfy
 for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2019 22:46:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jfFRBba+HrXzPtnLLkqdxGZhTr4bv/R0fv80eG1X1wA=; b=UFTnfwfJQ+iKUYHTbB5e9ISAl
 nzFxznuKSHJjQ2mGw+CYJJrE6eQBiBjxDs+JCQfk0yzSZuTn9d8dtta/9tLkL+nfabApfR3WbB8q5
 blms0Zm5b41amefScxmYYBI6JLewHu70DvnuKi8im94sLw4LNeXI2e0LoOHHLcUXSNAiVhSmx5Tzd
 VC+RLhyEdSRMBIEzwPqIUwDdLpJ6Ku0cOqUvJjSTZVCgwy0vtsd29gvEKAXnCmqsFiMdTfbwJJ5Qj
 o38z8aq5HapdS/mW9wEJv/TuNVhLNHmwVUS/vKuhgX37IFRXR5e0mzNwvMQKfpXEOMJdX+CNqJs2f
 iw0lzOPJw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
 Linux)) id 1i4ljJ-0002Vq-8L; Mon, 02 Sep 2019 12:46:45 +0000
Date: Mon, 2 Sep 2019 05:46:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <hsiangkao@aol.com>
Subject: Re: [PATCH 00/21] erofs: patchset addressing Christoph's comments
Message-ID: <20190902124645.GA8369@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901055130.30572-1-hsiangkao@aol.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Sep 01, 2019 at 01:51:09PM +0800, Gao Xiang wrote:
> Hi,
> 
> This patchset is based on the following patch by Pratik Shinde,
> https://lore.kernel.org/linux-erofs/20190830095615.10995-1-pratikshinde320@gmail.com/
> 
> All patches addressing Christoph's comments on v6, which are trivial,
> most deleted code are from erofs specific fault injection, which was
> followed f2fs and previously discussed in earlier topic [1], but
> let's follow what Christoph's said now.

I like where the cleanups are going.  But this is really just basic
code quality stuff.  We're not addressing the issues with large amounts
of functionality duplicating VFS helpers.
