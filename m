Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF11A0161
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2019 14:12:15 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46JPkN4bYWzDqjG
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2019 22:12:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=141.146.126.78; helo=aserp2120.oracle.com;
 envelope-from=dan.carpenter@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="fICn6659"; 
 dkim-atps=neutral
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46JPkF42fszDqC0
 for <linux-erofs@lists.ozlabs.org>; Wed, 28 Aug 2019 22:12:04 +1000 (AEST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7SCApOd168816;
 Wed, 28 Aug 2019 12:11:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=jxuwhh6N6Ylboq2mCwfPlVJ1Ye3Dfi5dlfJtglOof1Q=;
 b=fICn6659VoWixS1b7QywOccoNdrMnfF4tZs1s+76TlMC1s0bE+zb9mgtH1sNOTmD1njx
 dQL60kCtGlzi/6pxF9j9VWPIQ6mYjS1/h514pRQzZNJjAOZe2zfXKUo0lYycyLrZRmg4
 pHsS8F0OkSP/GL6si4LEV/z4o2ao7URs453NC6dvx6KBXycY6nFDWC15Ag3bGBHi8F/G
 2ryUC6HgQxrWiYNeUqfP8OL/Ao5kuGeI8kmIkmXWs9Arf6w6j3EeqC3e9XqU/aPSpVrX
 0G7R+MfnogLK1zNl143oFbUCRyJenutTyiMrpUIkcIlTqiYaakkk3rrctWbWaZO0H1ig aw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2unscq809r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Aug 2019 12:11:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7SC7gaF046358;
 Wed, 28 Aug 2019 12:11:57 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 2undupvw9k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Aug 2019 12:11:57 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7SCBoPf020868;
 Wed, 28 Aug 2019 12:11:50 GMT
Received: from kadam (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 28 Aug 2019 05:11:49 -0700
Date: Wed, 28 Aug 2019 15:11:44 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [bug report] staging: erofs: introduce erofs_grab_bio
Message-ID: <20190828121143.GC8372@kadam>
References: <20190828105541.GA21320@mwanda>
 <20190828110249.GA56298@architecture4>
 <20190828113929.GA68628@architecture4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828113929.GA68628@architecture4>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=869
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908280131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=925 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908280132
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
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org, miaoxie@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Aug 28, 2019 at 07:39:29PM +0800, Gao Xiang wrote:
> (p.s. It makes me little confused these subject prefixes are "[bug report]", if they are
> really bugs, that is fine... If it be something unconfirmed (need our confirmation..,),
> could you kindly change the prefix into some other representations...? I will still look
> into all of them at least... and that makes me feel a bit better and easy.... thanks...)

Of course I thought it *was* a bug...

I've sent probably 1800 of these emails.  It's a script but I look over
the email before sending.  Maybe when people start using the Link: tag
I will be able to make these show up as reply to an email.

Normally, I sent them out in a much more timely sort of way but all the
erofs warnings show up as new with the move out of staging so I have
been re-reviewing the warnings.

So last August when this code was new, I must have seen the warning but
read the code correctly.  I checked before I sent this email to make
sure we hadn't discusssed it before.

But this time I got confused by the DBG_BUGON().  I decided to treat it
as a no-op because it can be configured to do nothing if you have
CONFIG_EROFS_FS_DEBUG disabled.  Plus it has "DBG" in the name so it
felt like debug code.  But I ended up focussing on it instead of seeing
the "(nofail ? __GFP_NOFAIL : 0)" bit.  The DBG_BUGON() is unreachable
and misleading nonsense fluff.  :(

regards,
dan carpenter

