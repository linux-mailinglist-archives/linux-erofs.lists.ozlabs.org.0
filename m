Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 872271744EE
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Feb 2020 05:51:21 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48TvBG6htjzDr7K
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Feb 2020 15:51:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1582951878;
	bh=AxDI3Ru54g3+QxUNFScLbFlwy3YWtTbQItGreYbJyk0=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=joN5JoB2JMZhvLCUA4gPsRj/5twCl4M/EcV4A8nEZQjGMccGpogwBRrlswTzeW+5A
	 x9q0LRk9SDUg7Ow26U/mCIMNYhWUaJaWXQbqWFC1ZZndNxOc1ucXmHVEmQmVPERC26
	 Fa2XICjP52bLggqrh8p+gnOGbV92oUgGZ6HNQtzZLiaqqGdqTJUypiM/CxHWOTlwBQ
	 xEYfyj/3YD6JJUGhYMvai0SkYYtHIs76G13EZoTTo6lHVciJ4VSasACAqp3XG4RCga
	 +MwIeyEQHdQhpR18ocR7KXsfGjeII4N1+YvSfLoP5FddIOxhKKLrbY0T4NJXyY4+Sw
	 DZ1czDX8uqCzA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.84; helo=sonic313-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=RUAinSMO; dkim-atps=neutral
Received: from sonic313-21.consmr.mail.gq1.yahoo.com
 (sonic313-21.consmr.mail.gq1.yahoo.com [98.137.65.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48TvB65qJVzDqyJ
 for <linux-erofs@lists.ozlabs.org>; Sat, 29 Feb 2020 15:51:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1582951864; bh=FiSGQ8fN3th9vrikeFRzu+BHVkhKDAXonicQedsKVO8=;
 h=From:To:Cc:Subject:Date:References:From:Subject;
 b=RUAinSMOc57cq4hlkz0Q465u2X77NzFYKGyTUWwkpAzyWH6shORfFBj+w7cHjk+67Nyxfb+5RjiC8Nmeg2xNvd7L6ormjUQfI0MDlZvzVEPOjBCCRhK4kEbfo3zz8QKlpcMsN8f8HRLQqjai2F/+CtCKfBeFEOnWgAjfTDktrM2PO4BcsL3nnIW+2BUdUJMnhlhn3V0Rrdr8FJS9RYFCft+LCDbF5xnFVNSUYcsSNh9NKLPwNnmRvr30Kd21nd5D8GRufQZ4QWF9oTwt/HfjFWHE4wIjXIUKvYPW8BeZlmXlZJpkb8FA+RyzXDFKVfkf595C5ITLVCLhjqqOMpuXlg==
X-YMail-OSG: jJxK7ykVM1n7KyiCtjdu35xJsn9M.g6KQZ6aoWJlU_tgWTfbLUvtBPdDPRuDRyf
 AtOQ59SC1JsrMiL6eB9B5v4wF4Q1RZD9WEHCXlwawjk5s6MwNTQr.GgSNJiowc9ITBIBxy6HFqCa
 LtlI5kpQ9IOJvLirXlL6FIT6rJb8JpaZUS7s7l9CiCdaYoia7d88evnx4NPgZZNv76ul_NwCQP6w
 CLEL9UfEj1qIWMWVpRBjravf67Z37woYgrHRBOlZtf3woWobZcyluWH5l80rZbF0ypYNwMBZTrg8
 4ljryng2HswOl6Pfvzz1g5Xy7IsL3hLZgXxb6CWV2s2TqCwd0V27.Zqn2JrkV6CGuv4iI_nhT_r_
 zj8bOOT7aC7a1KYRNWcwmaGwrxuEm6X3B7JRS_5oivajHpIIbQZDlCI1JBlh7dEOyjWh4xtWMELp
 G2V6LfkOlJkYTkDn2FeR5pZ.3ZALxaOZpRxdzO0ETPdoNMToDmr67nHu7GMmcxjV1gJgfQLwIm0h
 L9C4bRrhkquNdl97OuLJAmb2crDxs2XXCDSLDLQW_anWK3k1s7KcDmba.OgSNXA7IONit9.moAwQ
 9iTxAEFD0gpVQGkxEBEoP1hBcoR2sr79oN6PgBwCjoQJUjFD9KJLhTd8odOQucI2tghXtMex4pkg
 3QIXKhvihZRnHOOP4MiUxgU133r30ABO_uZkEelpcbS6C2uRwBpKnEI4.kdmKAcrhUWNDWVrIs9B
 lQiA9pQmp9JCagokRq3LYFzJ8Ha0bcZpfxEJFxDJffVwVeE4HuKWGIAOpdQVLkPi1UcZe6qg_UUL
 VHMqn3SjWy_ZufFlanQb3qvUer_fYFCuFW.fYNYbSn5pBRZ8Y97Yjp2OK9eI4JZrosBmIKryxvWg
 4HwR2yPtHvGYEHq.whkJjmvib_yjV.iSZVluzf8srHqTbtT5gzbOhM4n2ytEktrm4nanc2EG1wAR
 bvHkSaGwqAaw3IDCQjNRbPvr7gCGHBIZqm_O4fn13.yXIFCED5VDUwA4aGsBhkRg3IwLr1T6WPTE
 M3txwvw66pdJqx3BoofTffiXPORTzLVPDiakWOuOvV1hyjTJsojjYcHxwMZ.j3oWDEVKHn4GBI5S
 AFzZg.1EAIOtQM3lBlP9wlJQkzpeFaa8vW2z.c3vjqA0YFWHKhmjMx2d_2MhsnDtzKk8TvgWeg9H
 4mksy_P5rDZirbNpb5XQxkfXl49fnaN0U_.uXjsqDxtMzT5ZdciQtOUEI3IQIkNLt0_qfxUPba1L
 uZ7.WH_rN2wwlPA1tKB1DOUdnOxooL.gAO2j4lNvVXnM16b3Op3_6hLV7_iSL5TcKu2LMO.SzLCj
 pYaqv0JPYwiuTSzGYuRr8JiXTGAWk8eELBdpsckVpFPlKjiwymzoiwPEowaf7lEyPVXZY7KNTMv2
 nDkW9a4vOWiM0I3.dfYE-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic313.consmr.mail.gq1.yahoo.com with HTTP; Sat, 29 Feb 2020 04:51:04 +0000
Received: by smtp409.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 16922bddfd3cbd213433d5c12bb81660; 
 Sat, 29 Feb 2020 04:51:02 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v0.0-20200229 00/11] ez: LZMA fixed-sized output
 compression
Date: Sat, 29 Feb 2020 12:50:06 +0800
Message-Id: <20200229045017.12424-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20200229045017.12424-1-hsiangkao.ref@aol.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <gaoxiang25@huawei.com>

This is a WIP PREVIEW patchset, just for archiving to open
source community only.

For now, it implements LZMA SDK-like GetOptimumFast approach
and GetOptimum is still on schedule.

It's still buggy, lack of formal APIs and actively under
development for a while...

Usage:
$ ./run.sh
$ ./a.out output.bin.lzma infile

It will compress the beginning as much as possible into
4k RAW LZMA block.

Thanks,
Gao Xiang

Gao Xiang (11):
  ez: add basic source files
  ez: add helpers for unaligned accesses
  ez: introduce bitops header file
  ez: lzma: add range encoder
  ez: lzma: add common header file
  ez: lzma: add byte hashtable generated with CRC32
  ez: lzma: add LZMA matchfinder
  ez: lzma: add LZMA encoder
  ez: lzma: checkpoint feature for range encoder
  ez: lzma: add fixed-sized output compression
  ez: lzma: add test program

-- 
2.20.1

