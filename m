Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F69FCE7C
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Nov 2019 20:10:36 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47DWK60NtkzF86g
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Nov 2019 06:10:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=156.151.31.86; helo=userp2130.oracle.com;
 envelope-from=dan.carpenter@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="Rryzj7rx"; 
 dkim-atps=neutral
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47DWK10zQZzF84T
 for <linux-erofs@lists.ozlabs.org>; Fri, 15 Nov 2019 06:10:22 +1100 (AEDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAEJ92p1143647;
 Thu, 14 Nov 2019 19:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=KxPEfF4S4gu89WizE5xbIL2/rV9rybYbVaoS/D/rGp4=;
 b=Rryzj7rxWEaIOVoVFoc2dLZCnJ9fRCN2acE0SZ0+EGS5KlX7gsj0fbgTGOm8CM00Q+eO
 qEC8NtCx1gTP9p+wz7zORJcZVPBvyXiUWwhwznZeImnNh84IqatFP3BzTaYvEHgrgcUk
 8Qbq0mKOq4fhciioeedITrPndgcd3VpOuwxKpx0PrQpDo/QWeM7ot8q7U4ffveQrX3zV
 LKQH5W//HXI2wCmjTKzSzeh7yU1a6SqmHXJ29PHkimkrVENT9Y+u0XZMhnYHo9rQovWh
 jQrFlGFPfhyYjgz/vvmiQyJQhBN5HMbGqrvBeh7DHq/rPH6M4peHIPYcjCKzHyiHiqpV zQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2w5mvu59jx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Nov 2019 19:10:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAEJ8tif089040;
 Thu, 14 Nov 2019 19:10:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 2w8g19vua1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Nov 2019 19:10:14 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAEJADgB000938;
 Thu, 14 Nov 2019 19:10:13 GMT
Received: from kili.mountain (/129.205.23.165)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 14 Nov 2019 11:10:12 -0800
Date: Thu, 14 Nov 2019 22:10:03 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: xiang@kernel.org
Subject: [bug report] staging: erofs: tidy up decompression frontend
Message-ID: <20191114190848.f6tlqpnybagez76g@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=871
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911140159
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=936 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911140159
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
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hello Gao Xiang,

The patch 97e86a858bc3: "staging: erofs: tidy up decompression
frontend" from Jul 31, 2019, leads to the following static checker
warning:

	fs/erofs/zdata.c:443 z_erofs_register_collection()
	error: double unlocked 'cl->lock' (orig line 439)

fs/erofs/zdata.c
   432          cl = z_erofs_primarycollection(pcl);
   433          cl->pageofs = map->m_la & ~PAGE_MASK;
   434  
   435          /*
   436           * lock all primary followed works before visible to others
   437           * and mutex_trylock *never* fails for a new pcluster.
   438           */
   439          mutex_trylock(&cl->lock);
                ^^^^^^^^^^^^^^^^^^^^^^^^
   440  
   441          err = erofs_register_workgroup(inode->i_sb, &pcl->obj, 0);
   442          if (err) {
   443                  mutex_unlock(&cl->lock);
                        ^^^^^^^^^^^^^^^^^^^^^^^
How can we unlock if we don't know that the trylock succeeded?

   444                  kmem_cache_free(pcluster_cachep, pcl);
   445                  return -EAGAIN;
   446          }
   447          /* used to check tail merging loop due to corrupted images */
   448          if (clt->owned_head == Z_EROFS_PCLUSTER_TAIL)
   449                  clt->tailpcl = pcl;
   450          clt->owned_head = &pcl->next;
   451          clt->pcl = pcl;
   452          clt->cl = cl;
   453          return 0;

regards,
dan carpenter
