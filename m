Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E30A0058
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2019 12:58:08 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46JN4r5cTCzDr3B
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2019 20:58:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=156.151.31.85; helo=userp2120.oracle.com;
 envelope-from=dan.carpenter@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="m93vEM4l"; 
 dkim-atps=neutral
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46JN4m1QPyzDr2r
 for <linux-erofs@lists.ozlabs.org>; Wed, 28 Aug 2019 20:57:58 +1000 (AEST)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7SAudN3105003;
 Wed, 28 Aug 2019 10:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=KHQfD0ka1W8XDAfL6RInYsPClsbMTfsUUg9IDN0PeIA=;
 b=m93vEM4lKuUusCwBwnr9Nfe3kY6/dKG3PCHRQ9r0e24zwkvBU7kP78cqOmpagTIVEPkj
 FsJJAKEO0OsWaIPIFaR5kt3AeHcucH9J08Kg1rcIW3JuUk8qNaekOhgH76B+AFsAd9IQ
 ZYiWh8nt8aazxnrNO9nFfrxRXd8FoWRKD4DfxVtcDCfr0WFsdRaCnvl5dqG0Vc2sE0Hn
 4QEUuyffYmwuByFj9T9Ck6/Se15kd056MlWIvxmwLoN28s0Y/uisoBnNtINl9vrMkGz/
 sgKvmvPmbtLfUbXWRuTauEIm2EaRULE2/Xep33SoyC4rqf3mlR9WD7+R5RcRs2yXrec5 Pg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2unr9u00ca-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Aug 2019 10:57:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7SAr987056573;
 Wed, 28 Aug 2019 10:55:50 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2unduptjrm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Aug 2019 10:55:50 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7SAtlUK005883;
 Wed, 28 Aug 2019 10:55:47 GMT
Received: from mwanda (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 28 Aug 2019 03:55:46 -0700
Date: Wed, 28 Aug 2019 13:55:41 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: xiang@kernel.org
Subject: [bug report] staging: erofs: introduce erofs_grab_bio
Message-ID: <20190828105541.GA21320@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=706
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908280117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=767 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908280117
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hello Gao Xiang,

The patch 8be31270362b: "staging: erofs: introduce erofs_grab_bio"
from Aug 21, 2018, leads to the following static checker warning:

	fs/erofs/zdata.c:1272 z_erofs_vle_submit_all()
	error: 'bio' dereferencing possible ERR_PTR()

fs/erofs/zdata.c
  1259                  if (bio && force_submit) {
  1260  submit_bio_retry:
  1261                          __submit_bio(bio, REQ_OP_READ, 0);
  1262                          bio = NULL;
  1263                  }
  1264  
  1265                  if (!bio) {
  1266                          bio = erofs_grab_bio(sb, first_index + i,
  1267                                               BIO_MAX_PAGES, bi_private,
  1268                                               z_erofs_vle_read_endio, true);

This assumes erofs_grab_bio() can't fail.  It returns ERR_PTR(-ENOMEM)
on failure.

  1269                          ++nr_bios;
  1270                  }
  1271  
  1272                  err = bio_add_page(bio, page, PAGE_SIZE, 0);
  1273                  if (err < PAGE_SIZE)
  1274                          goto submit_bio_retry;
  1275  
  1276                  force_submit = false;
  1277                  last_index = first_index + i;
  1278  skippage:
  1279                  if (++i < clusterpages)
  1280                          goto repeat;

regards,
dan carpenter
