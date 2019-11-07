Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA63F2913
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Nov 2019 09:29:06 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 477xQ73fYvzF5yx
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Nov 2019 19:29:03 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 477wxw4rK7zF3B3
 for <linux-erofs@lists.ozlabs.org>; Thu,  7 Nov 2019 19:08:02 +1100 (AEDT)
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 974C92D7D77B7B803E15
 for <linux-erofs@lists.ozlabs.org>; Thu,  7 Nov 2019 15:22:20 +0800 (CST)
Received: from dggeme765-chm.china.huawei.com (10.3.19.111) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 7 Nov 2019 15:22:20 +0800
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 dggeme765-chm.china.huawei.com (10.3.19.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Thu, 7 Nov 2019 15:22:19 +0800
Received: from dggeme762-chm.china.huawei.com ([10.8.68.53]) by
 dggeme762-chm.china.huawei.com ([10.8.68.53]) with mapi id 15.01.1713.004;
 Thu, 7 Nov 2019 15:22:20 +0800
From: "Gaoxiang (xiang, OS Lab)" <gaoxiang25@huawei.com>
To: "liguifu (C)" <bluce.liguifu@huawei.com>, "Yuchao (T)" <yuchao0@huawei.com>
Subject: =?gb2312?B?s7e72DogW1BBVENIIDIvMl0gZXJvZnMtdXRpbHM6IHN1cHBvcnQgMTI4LWJp?=
 =?gb2312?Q?t_filesystem_UUID?=
Thread-Topic: [PATCH 2/2] erofs-utils: support 128-bit filesystem UUID
Thread-Index: AQHVlTwX/PBg2/RXRUaNR0gX3wdm3A==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 35
X-FaxNumberOfPages: 0
Date: Thu, 7 Nov 2019 07:22:20 +0000
Message-ID: <84997c2a3a2f4ac8bae1995bb4c4012c@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.223.43]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
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
Cc: "miaoxie \(A\)" <miaoxie@huawei.com>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

R2FveGlhbmcgKHhpYW5nLCBPUyBMYWIpIL2rs7e72NPKvP6hsFtQQVRDSCAyLzJdIGVyb2ZzLXV0
aWxzOiBzdXBwb3J0IDEyOC1iaXQgZmlsZXN5c3RlbSBVVUlEobGhow==
