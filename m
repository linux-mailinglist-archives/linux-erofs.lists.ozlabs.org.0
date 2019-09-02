Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id DA854A5604
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2019 14:29:49 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46MTtM1C21zDqVP
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2019 22:29:47 +1000 (AEST)
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
 header.b="qLGt2hfP"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46MTpd4V6qzDqdp
 for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2019 22:26:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=svUkB0dxi2TuM3Fl0ZlJgO11nAP1/canIdeXNo7nLhk=; b=qLGt2hfPD/A3ccp43tsVxEP+x
 jUUBvQ2XSyyvgDYe6TrtxZgmxG16PIqrFXwYQD0yu1nwGhSCRVMgr+BdkXiKj/jUe/2dQ5P7VV3pB
 mpwJArbHQTIKn0n527nkd8xUQJNtgNtVG8et41zGsCgOkMzEOlCzz45lNssyF4O0wqmBgl6Ukn6n/
 8ofbDkQMFNYqoFQnvcgy+ixWOpyh3PXymSyceVE8mrA4rAByp/dH+mwABAy8SkQ5g83bFmoNvqLB1
 XOC0h+5IQadmsREIEoQJIxKs+Dac3mR4wbOu6xrUwlc8scnfiePGNF1jWbmmkDViTqxZwhaFQrhQG
 w8IvWePTA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
 Linux)) id 1i4lPf-00042m-Hk; Mon, 02 Sep 2019 12:26:27 +0000
Date: Mon, 2 Sep 2019 05:26:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <hsiangkao@aol.com>
Subject: Re: [PATCH 16/21] erofs: kill magic underscores
Message-ID: <20190902122627.GN15931@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190901055130.30572-17-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901055130.30572-17-hsiangkao@aol.com>
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

>  
> -	vi->datamode = __inode_data_mapping(advise);
> +	vi->datamode = erofs_inode_data_mapping(advise);
>  
>  	if (vi->datamode >= EROFS_INODE_LAYOUT_MAX) {

While you are at it can we aim for some naming consistency here?  The
inode member is called is called datamode, the helper is called
inode_data_mapping, and the enum uses layout?  To me data_layout seems
most descriptive, datamode is probably ok, but mapping seems very
misleading given that we've already overloaded that terms for multiple
other uses.

And while we are at naming choices - maybe i_format might be
a better name for the i_advise field in the on-disk inode?

> +	if (erofs_inode_version(advise) == EROFS_INODE_LAYOUT_V2) {

I still need to wade through the old thread - but didn't you say this
wasn't really a new vs old version but a compat vs full inode?  Maybe
the names aren't that suitable either?

>  		struct erofs_inode_v2 *v2 = data;
>  
>  		vi->inode_isize = sizeof(struct erofs_inode_v2);
> @@ -58,7 +58,7 @@ static int read_inode(struct inode *inode, void *data)
>  		/* total blocks for compressed files */
>  		if (erofs_inode_is_data_compressed(vi->datamode))
>  			nblks = le32_to_cpu(v2->i_u.compressed_blocks);
> -	} else if (__inode_version(advise) == EROFS_INODE_LAYOUT_V1) {
> +	} else if (erofs_inode_version(advise) == EROFS_INODE_LAYOUT_V1) {

Also a lot of code would use a switch statements to switch for different
matches on the same value instead of chained if/else if/else if
statements.

> +#define erofs_bitrange(x, bit, bits) (((x) >> (bit)) & ((1 << (bits)) - 1))

> +#define erofs_inode_version(advise)	\
> +	erofs_bitrange(advise, EROFS_I_VERSION_BIT, EROFS_I_VERSION_BITS)
>  
> +#define erofs_inode_data_mapping(advise)	\
> +	erofs_bitrange(advise, EROFS_I_DATA_MAPPING_BIT, \
> +		       EROFS_I_DATA_MAPPING_BITS)

All these should probably be inline functions.
