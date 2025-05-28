Return-Path: <linux-erofs+bounces-370-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC8FAC6478
	for <lists+linux-erofs@lfdr.de>; Wed, 28 May 2025 10:28:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b6jM14Nvyz2yMw;
	Wed, 28 May 2025 18:28:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.51
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748420909;
	cv=none; b=d6oyfy28y5HAb21+xcDrxITpRlB4KJbTQYehaoX7/K6s58VlQ1zsUq8CSdFEJelRbsLNv+unJASnAcDqaYZFNEnbtQhOGlLGkRoXBKuL17Ja4f526vgOYRgYB4Yj2V/sC8QYXxOdGg8L96zxh6ZzSpyo24zrLjDZdh8hUNyZzOBiGoiMXyrjd9WxuZivwhPYlnmc8vmoDB2qTbqQer2FEOZrp7+v3/BdJ49kK1Tme3e9fM27Yv3oyOYR6KYAgv7aDw1yUYvJ27lXKkQBmngAPQkCLzR+LRIOHKBKxukqchzbBHqzndzymSL6gfU3PjkbpWJK7C91/onPwVK4HLUPNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748420909; c=relaxed/relaxed;
	bh=Ojd7iMoppI0Vmr8htaS6S4vgrqwMyDhGX+qRFtVJFaI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bUB9EvB5dRTBKROEcTZGlM+kObvgcUyHcryPrpR1YRH++RwJ63E66bWICmC7/UhBUihEPgvE5k7fT5bbak1HayGpCouknGgvN9DfNKH3K6u9j2s2eRlndEPnSTMHzryBQbpwglYiPeJBhh4ZVF1gT4ivSl/5HvoZ+VM0QS0DWu21DjHCnoOfjZ5GeEa43FlW6H2sir1OP2BfzSkkH2ZMeF8DhGT8J7+KRJWyTecJo/7fuEzXPdAqTYqJWZvthsaU4yT3oDCfLDizOPGIZjAr8xBO3gsMXhlpMrDqpsccJYJOCOlZBvEhjXqHPV1KtMZ7xHr3MSHzgDl17zkw6d4GSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=wozizhi@huaweicloud.com; receiver=lists.ozlabs.org) smtp.mailfrom=huaweicloud.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=wozizhi@huaweicloud.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 920 seconds by postgrey-1.37 at boromir; Wed, 28 May 2025 18:28:28 AEST
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b6jM04QxYz2xlK
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 May 2025 18:28:26 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4b6j0p147cz4f3jtP
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 May 2025 16:12:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4B9C51A018D
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 May 2025 16:13:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAHa1+MxTZozegGNw--.47012S4;
	Wed, 28 May 2025 16:13:02 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: netfs@lists.linux.dev,
	dhowells@redhat.com,
	jlayton@kernel.org,
	brauner@kernel.org
Cc: hsiangkao@linux.alibaba.com,
	jefflexu@linux.alibaba.com,
	zhujia.zj@bytedance.com,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wozizhi@huawei.com,
	libaokun1@huawei.com,
	yangerkun@huawei.com,
	houtao1@huawei.com,
	yukuai3@huawei.com
Subject: [QUESTION] cachefiles: Recovery concerns with on-demand loading after unexpected power loss
Date: Wed, 28 May 2025 16:07:59 +0800
Message-Id: <20250528080759.105178-1-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
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
X-CM-TRANSID:gCh0CgAHa1+MxTZozegGNw--.47012S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJr47CF1DWr4fCw15XF13Arb_yoW8JFy5pF
	ZI9w1UK34kXFZ7K3s7AF48uryfZ3s5AF4DXrWSqrWktrn0kF1Iqryaqr1UJFWUurZrG3y2
	qw1jyr9rAwnFvrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IUnUDG7UUUUU==
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Currently, in on-demand loading mode, cachefiles first calls
cachefiles_create_tmpfile() to generate a tmpfile, and only during the exit
process does it call cachefiles_commit_object->cachefiles_commit_tmpfile to
create the actual dentry and making it visible to users.

If the cache write is interrupted unexpectedly (e.g., by system crash or
power loss), during the next startup process, cachefiles_look_up_object()
will determine that no corresponding dentry has been generated and will
recreate the tmpfile and pull the complete data again!

The current implementation mechanism appears to provide per-file atomicity.
For scenarios involving large image files (where significant amount of
cache data needs to be written), this re-pulling process after an
interruption seems considerable overhead?

In previous kernel versions, cache dentry were generated during the
LOOK_UP_OBJECT process of the object state machine. Even if power was lost
midway, the next startup process could continue pulling data based on the
previously downloaded cache data on disk.

What would be the recommended way to handle this situation? Or am I
thinking about this incorrectly? Would appreciate any feedback and guidance
from the community.

Thanks,
Zizhi Wo


