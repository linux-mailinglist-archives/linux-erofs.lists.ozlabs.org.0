Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 711409E591
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Aug 2019 12:19:59 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46HlHJ6g9qzDqWw
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Aug 2019 20:19:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=141.146.126.78; helo=aserp2120.oracle.com;
 envelope-from=dan.carpenter@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="NcsjQwzh"; 
 dkim-atps=neutral
X-Greylist: delayed 1523 seconds by postgrey-1.36 at bilbo;
 Tue, 27 Aug 2019 20:19:52 AEST
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46HlHD0cPMzDqT6
 for <linux-erofs@lists.ozlabs.org>; Tue, 27 Aug 2019 20:19:50 +1000 (AEST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7R9s9pF027271;
 Tue, 27 Aug 2019 09:54:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=e3vP6/n2I9OZ1p8MzxGzS3p5LdGVcFsK2O/M00K8cZU=;
 b=NcsjQwzhkGsChG4CARqsj//9ZQCwJljSfuvZEQanGGPFCIcS5PBCr2Ob3xpHsdDBicAX
 DZZUThgzTbZ1Mvna/xPnmdhKjzHcL1Rcwol5hiLT9/7OFmVLB038I2FhlgrmWrFjzr52
 6MgHg84c/tALPPsqzLMsthAYYhbnpnZT3jjAYW6J2lxCY63e98NwJmTnq0+j8EPvmHzg
 a9tTLvoww7R1sL47MwDtgk1WZ3AqjkIq8VhPEOVu5UQ/6VLgSVrurz1SZZqejTmL+Sp/
 I3DgsqXSaR/ZNh8f80RTuUhS6IcW4gY3IHIA1mZF1EJWO0fcQNGZZ6G2KvnXbk0IZJe+ 8w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2un25701x9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Aug 2019 09:54:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7R9rFSo129611;
 Tue, 27 Aug 2019 09:54:15 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 2umhu8hpjn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Aug 2019 09:54:15 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7R9rrMf012844;
 Tue, 27 Aug 2019 09:53:53 GMT
Received: from kadam (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 27 Aug 2019 02:53:53 -0700
Date: Tue, 27 Aug 2019 12:53:47 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [bug report] staging: erofs: tidy up decompression frontend
Message-ID: <20190827095347.GN3964@kadam>
References: <20190827090355.GA29280@mwanda>
 <20190827093629.GA55193@architecture4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827093629.GA55193@architecture4>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9361
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=713
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908270112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9361
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=776 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908270112
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
Cc: xiang@kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Aug 27, 2019 at 05:36:29PM +0800, Gao Xiang wrote:
> Hi Dan,
> 
> Thanks for your report.
> 
> On Tue, Aug 27, 2019 at 12:03:55PM +0300, Dan Carpenter wrote:
> > Hello Gao Xiang,
> > 
> > This is a semi-automatic email about new static checker warnings.
> > 
> > The patch 97e86a858bc3: "staging: erofs: tidy up decompression
> > frontend" from Jul 31, 2019, leads to the following Smatch complaint:
> > 
> >     fs/erofs/zdata.c:670 z_erofs_do_read_page()
> >     error: we previously assumed 'clt->cl' could be null (see line 596)
> > 
> > fs/erofs/zdata.c
> >    595			/* didn't get a valid collection previously (very rare) */
> >    596			if (!clt->cl)
> >                             ^^^^^^^^
> > New NULL check.
> > 
> >    597				goto restart_now;
> >    598			goto hitted;
> >    599		}
> >    600	
> >    601		/* go ahead the next map_blocks */
> >    602		debugln("%s: [out-of-range] pos %llu", __func__, offset + cur);
> >    603	
> >    604		if (z_erofs_collector_end(clt))
> >    605			fe->backmost = false;
> >    606	
> >    607		map->m_la = offset + cur;
> >    608		map->m_llen = 0;
> >    609		err = z_erofs_map_blocks_iter(inode, map, 0);
> >    610		if (unlikely(err))
> >    611			goto err_out;
> >    612	
> >    613	restart_now:
> >    614		if (unlikely(!(map->m_flags & EROFS_MAP_MAPPED)))
> >    615			goto hitted;
> >    616	
> >    617		err = z_erofs_collector_begin(clt, inode, map);
> 
> At a glance, clt->cl will be all initialized in all successful paths
> in z_erofs_collector_begin, or it all fall back into err_out...
> I have no idea what is wrong here...
> 
> Some detailed path from Smatch for NIL dereferences?
> 

Ah.  Sorry for that.  It's a false positive.  I will investigate and
fix Smatch.

regards,
dan carpenter

