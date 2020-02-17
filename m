Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id E23BF161B10
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Feb 2020 19:52:24 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48LtQD0y3CzDqB2
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Feb 2020 05:52:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=InMWRejZ; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48LtL54GSszDqjH
 for <linux-erofs@lists.ozlabs.org>; Tue, 18 Feb 2020 05:48:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=CZVbSaaYtwj3qyeImu1P+lH7PMVYW2dlgJQfIOhuLwI=; b=InMWRejZjziZ327gXZfH6Mbvr/
 C/eVJoLnvVckDeDyzrV7y7TgMN7L2n+c2kuawbG4CvlvTAyha1SY+K1dMvV+M/KVndPm9QVAOhiYo
 8o2+LVPKCXFmpk2cJIMtPz+PQe7MPFwlTqgCeHeus+DzjLHeMVZ2Zdtsj+MACIwCrSrxvG8dTTtZW
 IsGstqnGLWUQSUdZyALt6muTXBeoQ265Lj7NA7RwwyS1WYlqOrdhFvczcsXEHghUSOEddnFA/bh3o
 rlYzYW3LI/v4mBl1+4g7qezJwwaoolJXkQhuMF6EOe7aVsuIM/2l1RZhxe9liukxnsF/LosclOFnG
 HdvYL2KA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j3lRh-0006jH-1W; Mon, 17 Feb 2020 18:48:41 +0000
Date: Mon, 17 Feb 2020 10:48:40 -0800
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 00/19] Change readahead API
Message-ID: <20200217184840.GL7778@bombadil.infradead.org>
References: <20200217184613.19668-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217184613.19668-1-willy@infradead.org>
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
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Feb 17, 2020 at 10:45:41AM -0800, Matthew Wilcox wrote:
> This series adds a readahead address_space operation to eventually

*sigh*.  Clearly I forgot to rm -rf an earlier version.  Please disregard
any patches labelled n/16.  I can send a v7 if this is too much hassle.
