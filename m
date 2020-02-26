Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id E47481705B5
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Feb 2020 18:12:55 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48SMnJ67t3zDqkR
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Feb 2020 04:12:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=156.151.31.85; helo=userp2120.oracle.com;
 envelope-from=darrick.wong@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256
 header.s=corp-2020-01-29 header.b=AB69FvJ6; 
 dkim-atps=neutral
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48SMnD6bnYzDqdk
 for <linux-erofs@lists.ozlabs.org>; Thu, 27 Feb 2020 04:12:48 +1100 (AEDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01QHCatj193451;
 Wed, 26 Feb 2020 17:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=iw1oHBmXUdp5IIisAtDC6XniuQU/lJXPuIIsSzlu6CA=;
 b=AB69FvJ690epl2q3iEF9OAd01yCyTXgZ/0nRUe4hTTW1dVmeZsSnnrLlfl8WVjuet02R
 UvAohP4OexZPftYUUJFg0zP/4Ky/r1sIFhKYF18D6BOTL+4Fb8rbm0i+y3AK6usAQr7u
 9h0s6M1CJXYX7Gp8hZQVpVN5M+me+IhAGpuaVGJuseVKH2jSSWUxSZ2Pd9C3Wv8pPDWp
 NRLpae6sc2A1ll0fpZ2zQUeA43UmK9FEQWt1khRLfEV2Yeh3TOU5jJbkhIp/RGeQ7E3M
 ZxKg/iMXZIht/FzuXlYpXD41afPl/KsVkFMoj5MtROezpGcDt6M2eN19sEiew9VczPQI 4w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2ydct353mw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Feb 2020 17:12:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01QGmHuR157882;
 Wed, 26 Feb 2020 17:10:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by aserp3020.oracle.com with ESMTP id 2ydcs5j8nu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 26 Feb 2020 17:10:39 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01QHAdYU126581;
 Wed, 26 Feb 2020 17:10:39 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2ydcs5j8me-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Feb 2020 17:10:39 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01QHAcnt030079;
 Wed, 26 Feb 2020 17:10:38 GMT
Received: from localhost (/67.169.218.210)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 26 Feb 2020 09:10:38 -0800
Date: Wed, 26 Feb 2020 09:10:36 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v8 25/25] iomap: Convert from readpages to readahead
Message-ID: <20200226171036.GE8045@magnolia>
References: <20200225214838.30017-1-willy@infradead.org>
 <20200225214838.30017-26-willy@infradead.org>
 <20200226170425.GD8045@magnolia>
 <20200226170728.GD22837@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226170728.GD22837@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002260114
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
 Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net,
 cluster-devel@redhat.com, linux-mm@kvack.org, ocfs2-devel@oss.oracle.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Feb 26, 2020 at 09:07:28AM -0800, Christoph Hellwig wrote:
> On Wed, Feb 26, 2020 at 09:04:25AM -0800, Darrick J. Wong wrote:
> > > @@ -456,15 +435,8 @@ iomap_readpages(struct address_space *mapping, struct list_head *pages,
> > >  			unlock_page(ctx.cur_page);
> > >  		put_page(ctx.cur_page);
> > >  	}
> > > -
> > > -	/*
> > > -	 * Check that we didn't lose a page due to the arcance calling
> > > -	 * conventions..
> > > -	 */
> > > -	WARN_ON_ONCE(!ret && !list_empty(ctx.pages));
> > > -	return ret;
> > 
> > After all the discussion about "if we still have ctx.cur_page we should
> > just stop" in v7, I'm surprised that this patch now doesn't say much of
> > anything, not even a WARN_ON()?
> 
> The code quoted above puts the cur_page reference.  By dropping the
> odd refactoring patch there is no need to check for cur_page being
> left as a special condition as that still is the normal loop exit
> state and properly handled, just as in the original iomap code.

DOH.  Yes, yes it does.  Thanks for pointing that out. :)

/me hands himself another cup of coffee,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D
