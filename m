Return-Path: <linux-erofs+bounces-398-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE9DAD814B
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Jun 2025 04:55:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bJPC710fdz2yMF;
	Fri, 13 Jun 2025 12:55:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749783315;
	cv=none; b=GXbUR8n//UugskQk36Ejvz/AUJO/qK2Z/CWxnxH1osS9atSFKQw/hFaJna0y3+JQiDlnQRxmGglIjKfrI4peUiuuI8opMgPipebx4e1AzlSKIohbI4qFCknD+PEBbbLnExWrCPvzmu6fAGU+6DRVXZSx7Gf4hDs/NS633tonZbqzCvvYHgD+4oz1Q/cxTWK52HERW5ALlhLrZdl7Jwb90xvbS4N1EbUoRW7iCb3je7blCts3HBFfxS7e2KXYQ0alZRxMIRkWouCfBXBz8mMGELa2KsL2QIFZxFyh7pu0bbm1A/2g688ji4IpYyeL/qVeHzoGPuPok6N9KbKffIaqIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749783315; c=relaxed/relaxed;
	bh=Bk0pghWnCWdBO1NH6y+lDiL+29upUOFZxuYWtspWj8w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=E24wcXbqTtIU5+gI/B8LEaX9F/sEmqr0AFDWQSliL4GuebafV9hlgFD4/zgdjdS3PmPySaCWKHFuWzs8MvNnxkTpv7A6WtMptV7xO3rNJ5+TRr1vVtk/WgBCBD4VDWiQOx9z1B6Qntpbn/P2zSBtLVZCX5HwMTCxdUUroaB+/FiLRDU1MYsIdjKxwUID+0oNtFtX2orHOIUKwmc5wTkxTsxpeamhYu5HdMhoUprbPQA7UkbXly9Es+kdOKDl1IlSuPQlkiXcvMnNHiRKLZrRY7EvSIUOmijrJH5D3vQYhj+c7rRthtHV0FYf48KvbBhZbDjZpgb1/kObsVjNbvlmcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass (client-ip=216.40.44.11; helo=relay.hostedemail.com; envelope-from=rostedt@goodmis.org; receiver=lists.ozlabs.org) smtp.mailfrom=goodmis.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=goodmis.org (client-ip=216.40.44.11; helo=relay.hostedemail.com; envelope-from=rostedt@goodmis.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 360 seconds by postgrey-1.37 at boromir; Fri, 13 Jun 2025 12:55:13 AEST
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bJPC56XjDz2xHp
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Jun 2025 12:55:13 +1000 (AEST)
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 430AC160B58;
	Fri, 13 Jun 2025 02:49:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id B800C60013;
	Fri, 13 Jun 2025 02:49:07 +0000 (UTC)
Date: Thu, 12 Jun 2025 22:49:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>
Subject: Unused trace event in erofs
Message-ID: <20250612224906.15000244@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B800C60013
X-Spam-Status: No, score=0.0 required=3.0 tests=RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=disabled version=4.0.1
X-Stat-Signature: uaoocgjsrjds49dg1urx9xzjnucpez7i
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19dmni3gDNOYbl6Buih8pDWlCcmVoa3n6g=
X-HE-Tag: 1749782947-201819
X-HE-Meta: U2FsdGVkX1+Npnbb2LjhalCEdzBhqg8nBpYAH6nNAKTfYYmARJVFTicOE31+R8LLN0xAMDnEKluS4+g0zXdLpSVrL11sDFrm0ft8zXX9XIx7L3dJz/rr425dPVXnHrUTN0fkL2lyzvgYVKC9sij/YPsj2qZ1pYyArdMcjteIHKoa71jfXcbNqwAAFl85SHi8czMXLA1yWkRQ4n2xbSt/zkjKL0yn7kNLr+XY8mum1jMIbJwbDp8rf9SvGVzq89DlWAZLKIZvRg2OEbEgE7p0hDChYdDXaR83K9m8JgznTq4dLYEea/+2kv/3sNbD6jWWmsVSbh4I/YNxW9cDYWH6qiEoqVSRhJs6aO8se8AB7Mgq0PdUtAqjTlia8zhlyjj0obdTKp5CvMHQs8Tc4RbWMQ==
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

I have code that will trigger a warning if a trace event is defined but
not used[1]. It gives a list of unused events. Here's what I have for
erofs:

warning: tracepoint 'erofs_destroy_inode' is unused.

Each trace event can take up to around 5K in memory regardless if they
are used or not. Soon there will be warnings when they are defined but
not used. Please remove any unused trace event or at least hide it
under an #ifdef if they are used within configs. I'm planning on adding
these warning in the next merge window.

Thanks,

-- Steve

[1] https://lore.kernel.org/linux-trace-kernel/20250612235827.011358765@goodmis.org/

