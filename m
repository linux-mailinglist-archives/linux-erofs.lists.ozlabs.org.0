Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 6706118B28E
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2020 12:50:13 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48jlZp1wflzDrFJ
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2020 22:50:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=156.151.31.86; helo=userp2130.oracle.com;
 envelope-from=william.kucharski@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256
 header.s=corp-2020-01-29 header.b=q1IDVvl5; 
 dkim-atps=neutral
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48jlZg6K2kzDr1q
 for <linux-erofs@lists.ozlabs.org>; Thu, 19 Mar 2020 22:49:57 +1100 (AEDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02JBgsVq127221;
 Thu, 19 Mar 2020 11:49:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=v7zEP7RtOUJktHuCXePFovWTz/T8i1lu/X2pjX1Hbbo=;
 b=q1IDVvl5ksTsjXMbCDWj+a3knqn+SAHj/kDVhAi11PV27RLxJ7D84msk3su8F04N1ajL
 VtqrcyTWBH0XhNSdSJ+JoSXHTgADauE0jfg1mDGVKuEw3I+JKcprJZAQNJ67JazR1VfE
 s3nm4Mf2oLZniCcfJJdP7T/ANyYbU4s+dxO14S5bHxqvtm+OOPUw9aIFsxOexf+QnfE4
 nS1BcO0nXJUGlSbAjYbOp8Kg+MDPXQTVBjY8E/fEVMcttJpKG8oLSAmAMwFBF0da2i3V
 rtwh4u6bTlBb4uIs0HtIYHl1MWNpOrxuuhyAWktvecikT5IAiVm05EkMOiaYi9QZ7L5m CA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2yrpprfua2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Mar 2020 11:49:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02JBgha2113568;
 Thu, 19 Mar 2020 11:49:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by userp3030.oracle.com with ESMTP id 2ys8rkw5nk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 19 Mar 2020 11:49:43 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 02JBngEO129865;
 Thu, 19 Mar 2020 11:49:42 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 2ys8rkw5mf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Mar 2020 11:49:42 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02JBnfQm014664;
 Thu, 19 Mar 2020 11:49:41 GMT
Received: from [192.168.0.110] (/73.243.10.6)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 19 Mar 2020 04:49:41 -0700
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v8 00/25] Change readahead API
From: William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20200225214838.30017-1-willy@infradead.org>
Date: Thu, 19 Mar 2020 05:49:38 -0600
Content-Transfer-Encoding: 7bit
Message-Id: <09A89B86-9F2E-4829-9180-AA81320CE2FE@oracle.com>
References: <20200225214838.30017-1-willy@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9564
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1011
 impostorscore=0 priorityscore=1501 spamscore=0 mlxlogscore=768 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003190054
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
 linux-mm <linux-mm@kvack.org>, ocfs2-devel@oss.oracle.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

For the series:

Reviewed-by: William Kucharski <william.kucharski@oracle.com>
