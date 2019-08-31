Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8B2A4436
	for <lists+linux-erofs@lfdr.de>; Sat, 31 Aug 2019 12:58:45 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46LCyB6cLwzDqjl
	for <lists+linux-erofs@lfdr.de>; Sat, 31 Aug 2019 20:58:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=156.151.31.85; helo=userp2120.oracle.com;
 envelope-from=dan.carpenter@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="czS+OJhh"; 
 dkim-atps=neutral
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46LCy06t9hzDqMf
 for <linux-erofs@lists.ozlabs.org>; Sat, 31 Aug 2019 20:58:30 +1000 (AEST)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7VAt6gS012369;
 Sat, 31 Aug 2019 10:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=ozxVxnuhOlY8BW1RqOr9u3YWuE9zaJOBgn+uoApcv8w=;
 b=czS+OJhht/1HYcIw838trx7yLziM6sLYkilzvRpGO1UPTBNoOj82c4EBPcBLNPe8px7u
 STu04aDn26y26C0eaeB18B3O833x1zPr8QF+o2cFs2yGFHBav96r1SjmzIRaJXPmDlqY
 tr20ommYshXLk8YK2INTeHVUs6ZO9QLwO7tAn1MIETU4HAtsJrC2QCMBt4FldBAnfw2V
 8wNO6jcWZ7jyKzWVwjruunLrC4aEzcCvToanK2KLZg+tAUWedDaj2cX5YTFLmS0vrhhT
 KiIxgXeAnDoLCHeSH1R/sI4Nvyw+UPiQS+fI0II7yznVdVItgojBy2m+f6UMiAk5IKpE 6Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2uqqje006y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 31 Aug 2019 10:57:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7VArlar022869;
 Sat, 31 Aug 2019 10:57:55 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 2uqgqhyvmq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 31 Aug 2019 10:57:55 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7VAvh9D025043;
 Sat, 31 Aug 2019 10:57:44 GMT
Received: from kadam (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sat, 31 Aug 2019 03:57:43 -0700
Date: Sat, 31 Aug 2019 13:57:32 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH v3 6/7] erofs: remove all likely/unlikely annotations
Message-ID: <20190831105732.GH8372@kadam>
References: <20190830032006.GA20217@architecture4>
 <20190830033643.51019-1-gaoxiang25@huawei.com>
 <20190830033643.51019-6-gaoxiang25@huawei.com>
 <20190830154650.GB11571@infradead.org>
 <20190830160415.GC69026@architecture4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830160415.GC69026@architecture4>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9365
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=786
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908310129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9365
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=847 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908310129
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
 Miao Xie <miaoxie@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, weidu.du@huawei.com,
 Joe Perches <joe@perches.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Aug 31, 2019 at 12:04:20AM +0800, Gao Xiang wrote:
> I don't have some benchmark data for each unlikely/likely case (and I have
> no idea "is that worth to take time to benchmark rather than do another more
> useful stuffs"), so..I have to kill them all...

We don't really require benchmarks, just that a reasonable person would
think it might make a difference.

regards,
dan carpenter
