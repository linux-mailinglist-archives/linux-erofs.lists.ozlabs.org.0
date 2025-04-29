Return-Path: <linux-erofs+bounces-260-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B390AA048B
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Apr 2025 09:31:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZmsS46W6Gz2xS9;
	Tue, 29 Apr 2025 17:31:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745911860;
	cv=none; b=EW0gzbNKTFkNWz7cFrBlbUaBry5ZnKJC3ty+gKzaiTq4Ag/wkGien3JYREwOuz6mifHJptj667fA6mPXiTK8emmLI6AEk2xAzcndoR58MRdwKdkafVydu3gQ/nG7o/dDClswrPw59U8XoajAsyPRhEVDp6Vb84lNE9lAoPfOVnvcbS8JVZ16MLz8oAlqMKzKXNLahrVa/+KhnfMAt8N81vjAcPwY+slh6u4JCF2SeKtvZepuCtgre4wdgFd0x65dx+FYBmDXGYMfDUYUxPyDNuZUvdfsaodga4iYoW6T0pMeFLPn1Th2orN2E819F8wnYbX/gNy1v/8tjAgvTalYmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745911860; c=relaxed/relaxed;
	bh=7x8ccxeHUmTFurPjCA4jkRqsV5JljHujHKQvW67uh2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W/P5Y+665e0P2QevDuJ28CqiGvWHGVMmSuT0tmYcUv4RVF5gjro/nwdOkVUXwNvXL7mA9rvBJc/b7gGX5mCVRNn+RUklriT7nNLz6jMveWzcWdrIbdy3WjwTXQjEv8P6kZZDIgNi9JIkr4ZQ+ee00g31z8cLmXTer5t36IH05jahjvb2zKtNDRKdPkUYv58SkV/4lq5NETueNhIJDUKwy6jvT19/S9vp8dnwOD/mVM+kDm1oBmdETKuGDYc4BHb4YaJ35wZAuYZpHae0/bTq+boU7lUzaGh9nizCGnuWlYyBoy7ixdmOmoueHUTz2uAyKV3NV+tdD35T6lm8CNJ+fA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EB5qMboG; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=egorenar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EB5qMboG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=egorenar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZmsS346mBz2xGw
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Apr 2025 17:30:58 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53T4ENcE015194
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Apr 2025 07:30:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=7x8ccxeHUmTFurPjCA4jkRqsV5JljHujHKQvW67uh
	2w=; b=EB5qMboGrKuCqgWXAfq67du1m3oQW2BHxX1/67JlvLf9PcHwTmMU50IYj
	Y9j74f9a8KpYN2AlLw+XhDtxzQuSotpEhSl3DZknO7+DQiRl/U7RlCnwGJPfDocC
	hdvu56op7EjIWgtVC845FmrDyTzntHGiJuZ/rusOCGQz38lqvkj6sD4Mk+XjDWYs
	2L2lvzQSM1G42ROPiu9r0YzAbnzVMmYIyQBoHE3m8idTh8jPObRIccmsgAVmCIbk
	CHeGBeReP/E1/R0ejD4CANwBcmdWYJeMHxRpNolDHX8QndkyHY+hT5IAndVappl9
	BylfXJ0jwCb6qri/V4P7CYPtePssg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46a7kk4wy7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Apr 2025 07:30:56 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53T7NPJp020508
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Apr 2025 07:30:55 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46a7kk4wy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 07:30:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53T64jcL024607;
	Tue, 29 Apr 2025 07:30:55 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 469c1m1y1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 07:30:54 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53T7UrRU35521148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 07:30:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44AB320040;
	Tue, 29 Apr 2025 07:30:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C79020043;
	Tue, 29 Apr 2025 07:30:53 +0000 (GMT)
Received: from li-0ccc18cc-2c67-11b2-a85c-a193851e4c5d.boeblingen.de.ibm.com (unknown [9.152.212.62])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Apr 2025 07:30:53 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: hsiangkao@linux.alibaba.com
Cc: linux-erofs@lists.ozlabs.org
Subject: [PATCH v1 1/1] erofs-utils: fix endiannes issue
Date: Tue, 29 Apr 2025 09:30:52 +0200
Message-ID: <20250429073052.53681-1-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OYSYDgTY c=1 sm=1 tr=0 ts=68108030 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=R4t4fwzZnpY-9mMn22QA:9 a=zZCYzV9kfG8A:10 a=0lgtpPvCYYIA:10
X-Proofpoint-GUID: aE3GELrWdhwxV_73ZwmHY__cELh4vzaY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDA1MiBTYWx0ZWRfXzlwupKlybjE1 Xusp1Ri1cDNBhNDuhokwUQp5r5iq7GT2KU/iGbS/U9toUXKy7O6wutHRzE2R9syFdjy1HRH2PgX QuIy00ygZsI6J9F/G4boRrjQ0LDNeBZpB86BG5jBrChRAfjf/qw6MoBVSjZOM2vrM0KKBgl5SMv
 C8IXAkOja9TaVTf59B0hE/0Dgf9onrLg5rFN7fm6sFSc0yP+Uhi76c7JSaDeYj1F2NzZ8gkc7Wk 4/87a9r57dsaxKKvUjcSWQJzxc7bQSf7NaoT5vS3yeXP5XJ3Phey/YgoAEVAcQ0gN3XCjQ95B7u zM05iRlGsqu+pzzZcjYUwM3ihR5h7pBKnTcOntgb+8Lq3piYxFBT03qOUcNpJJ2Fuz74HcQzGkH
 V0hOhiW4l/w3kQHV4+90DFgoZaA2oqTKluZ4IY36XcMTpmgU5byApZq/et910rhwQPFS+5Zg
X-Proofpoint-ORIG-GUID: xlg45GLrBJ6qvS2danRm92VSvjlK895u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=527 phishscore=0 mlxscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290052
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Super User <root@a8345034.lnxne.boe>

Macros __BYTE_ORDER, __LITTLE_ENDIAN and __BIG_ENDIAN are defined in
user space header 'endian.h'. Not including this header results in
the condition #if __BYTE_ORDER == __LITTLE_ENDIAN being always true, even on
BE architectures (e.g. s390x). Due to this bug the compressor library was
built for LE byte-order on BE arch s390x.

Fixes: bc99c763e3fe ("erofs-utils: switch to effective unaligned access")
Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
---
 include/erofs/defs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index 051a270531ca..196dfa8191a8 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -19,6 +19,7 @@ extern "C"
 #include <inttypes.h>
 #include <limits.h>
 #include <stdbool.h>
+#include <endian.h>
 
 #ifdef HAVE_CONFIG_H
 #include <config.h>
-- 
2.49.0


