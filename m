Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E4014D754
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Jan 2020 09:11:54 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 487Y3W282WzDqWc
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Jan 2020 19:11:51 +1100 (AEDT)
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
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=Woj0I4jn; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 487Y2Q05xRzDqWh
 for <linux-erofs@lists.ozlabs.org>; Thu, 30 Jan 2020 19:10:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SEQYndPiQmHOinSK+5y0b6xfiS41LxvS+Ygq8GPrsz0=; b=Woj0I4jnSm3FzQbmUq6+phIAE
 VpS2wAWZ6qzBTSiA6+KJLJeZ9IJQo1IqzfIFbO9F9U013MkZDuBKnAfT5OB68HV2xbY5/kB+RHbVE
 E8P7HSQNZWfZIyY8SuKKokFMl/gRwea6+t3lTcWic2MCWwljy7u9IP7KvM4SleQbf9WV0h7SBx0/r
 RlsnXkgBCOBUo60U2z1I/x5z8+WOFcrYrEUkrqxsd9ZAOBPILh+nkp14gflmaQYWVuhu3TkQ+OemW
 SXh8xd/27OU7EMzKIdB6M87ZCaFb7NYahHbS5SggQfDRIrmHZsY8eK4pkWy+xMjY0X27qIaQ+6ixP
 5RWDLmRFA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1ix4uZ-0000RV-KY; Thu, 30 Jan 2020 08:10:51 +0000
Date: Thu, 30 Jan 2020 00:10:51 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 07/12] erofs: Convert uncompressed files from readpages
 to readahead
Message-ID: <20200130081051.GM6615@bombadil.infradead.org>
References: <20200125013553.24899-1-willy@infradead.org>
 <20200125013553.24899-8-willy@infradead.org>
 <20200129005741.GJ18610@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129005741.GJ18610@dread.disaster.area>
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
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Jan 29, 2020 at 11:57:41AM +1100, Dave Chinner wrote:
> > +			bio = NULL;
> > +			put_page(page);
> >  		}
> >  
> > -		/* pages could still be locked */
> >  		put_page(page);
> 
> A double put_page() on error?

Yup, already fixed when Gao Xiang pointed it out ;-)
