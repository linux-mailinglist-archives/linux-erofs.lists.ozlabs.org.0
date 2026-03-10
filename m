Return-Path: <linux-erofs+bounces-2580-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WExOAzAIsGlregIAu9opvQ
	(envelope-from <linux-erofs+bounces-2580-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Mar 2026 13:01:52 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5121224C1D0
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Mar 2026 13:01:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVXXl017Pz3cDT;
	Tue, 10 Mar 2026 23:01:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.42.244.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773144086;
	cv=none; b=mxGev+no4h1ch/broaqRX/okozqpuqSXCuA8zl9ZgywAA9i/qZRcY2Cy6LaPXcQEqF0RB4mE6ZbD1FuR5ei3GiaYw+sHaE+ZJqdxs9iANyubD3SbrQp6vi466ONtgPBTl4dXDv52pa3WPfd9noM5hBIfxowyBbWf663ImtQSXIlEi+vlYMPBvwSwGNsbXOwod8YxzamFGPgpAznWiF5PZjRrrYc3i3Y8D4JWAXrYq+XmMFxG4NVADx+pozGKywgIOPE99OFwWcE+v2t7NupRMTa0EsnNFptrVHjZ90hY0gRXR0ivR9tSXPEhhGCXxs0QjO7q09MMfS8DQsMUn5zQUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773144086; c=relaxed/relaxed;
	bh=L53e3gW0kQLrLBgOYa/6JqhBkvbXxie8sR3ylnK3UOc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kwtg5jTNyWc5852uPTguI3mQwtQh4WHTxmAGiQbkdHrTQYGfkahP1neT1a/rDb/cdK2rBEV3fEDmXKLfCC30VzppmqW3UluIFdqfnkZHF3ZNLSmVf4nCZT+M10NNAsxfmrPCI/pDWvRbMaMJJrOHv51t2oeA3EHuMsSOGk6tOw7BlLwrK7xdR/NgCPGVFWQstTQJ1Wh23S/XCxKnO4vdNE+iw8Rck7UU+OJvGJ/6o4OXkmvptcNXy5mtP8U8vQSamb9+qy0tLosKprXVywG+QylLSara9M21rTzSroaUtqQj7Z0NE+zGLWjvwcnAJGBlu//MUk7BjK7vVoREcw6vmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; dkim=pass (1024-bit key; unprotected) header.d=avm.de header.i=@avm.de header.a=rsa-sha256 header.s=mail header.b=dZcJYTZu; dkim-atps=neutral; spf=pass (client-ip=212.42.244.119; helo=mail.avm.de; envelope-from=phahn-oss@avm.de; receiver=lists.ozlabs.org) smtp.mailfrom=avm.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=avm.de header.i=@avm.de header.a=rsa-sha256 header.s=mail header.b=dZcJYTZu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=avm.de (client-ip=212.42.244.119; helo=mail.avm.de; envelope-from=phahn-oss@avm.de; receiver=lists.ozlabs.org)
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVXXg5ksLz3cDS
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Mar 2026 23:01:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1773143722; bh=LK3zT21XXqhQvbEwg2nItTFGXqZVrRtI29hZHPSW/Rg=;
	h=From:Subject:Date:To:Cc:From;
	b=dZcJYTZuZDA4q/3hNz64Owdc1HJABJYJkt99++PaaLbW7gaZD9g2/iS9O5ENS8TqR
	 Wd0w2FXgMI0uZVVeVPaP0+G8ebTl5PjkrH+/Un6QvZSpSuAmb2VEM0TmWU3qAXNa/R
	 B92BBimBzpC3ASCEhSshSATaYHjIa50MBa4pF9SU=
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006a9-2367-7f0000032729-7f0000019ca8-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:22 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:21 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Subject: [PATCH 00/61] treewide: Use IS_ERR_OR_NULL over manual NULL check
 - refactor
Date: Tue, 10 Mar 2026 12:48:26 +0100
Message-Id: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAsFsGkC/x3M0QpAMBSA4VfRubYaNsyrSIvt4JRGZ5GSd7dcf
 hf//0BEJozQZQ8wXhRpDwlFnoFbx7CgIJ8MpSxrWUktJiUoWmS2O9twbpvQxph2bLysnILUHYw
 z3f+zH973A3+QboxjAAAA
X-Change-ID: 20260305-b4-is_err_or_null-59998a7d03c4
To: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, 
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-mm@kvack.org, 
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org, 
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org, 
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev, 
 Philipp Hahn <phahn-oss@avm.de>
Cc: Julia Lawall <Julia.Lawall@inria.fr>, 
 Nicolas Palix <nicolas.palix@imag.fr>, Chris Mason <clm@fb.com>, 
 David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, 
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, 
 Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, 
 Chunhai Guo <guochunhai@vivo.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
 Andreas Gruenbacher <agruenba@redhat.com>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Jan Kara <jack@suse.com>, 
 Phillip Lougher <phillip@squashfs.org.uk>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
 Valentin Schneider <vschneid@redhat.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 John Johansen <john.johansen@canonical.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Alasdair Kergon <agk@redhat.com>, 
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, 
 Benjamin Marzinski <bmarzins@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Jamal Hadi Salim <jhs@mojatatu.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Xin Long <lucien.xin@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jon Maloy <jmaloy@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Russell King <linux@armlinux.org.uk>, John Crispin <john@phrozen.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Zhenyu Wang <zhenyuw.linux@gmail.com>, Zhi Wang <zhi.wang.linux@gmail.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Igor Russkikh <irusskikh@marvell.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Michael Chan <mchan@broadcom.com>, 
 Potnuri Bharat Teja <bharat@chelsio.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Taras Chornyi <taras.chornyi@plvision.eu>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Iyappan Subramanian <iyappan@os.amperecomputing.com>, 
 Keyur Chudgar <keyur@os.amperecomputing.com>, 
 Quan Nguyen <quan@os.amperecomputing.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, Marc Zyngier <maz@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Vinod Koul <vkoul@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Alex Williamson <alex@shazbot.org>, 
 Mark Greer <mgreer@animalcreek.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Dave Penkler <dpenkler@gmail.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>, 
 Georgi Djakov <djakov@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=10360; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=LK3zT21XXqhQvbEwg2nItTFGXqZVrRtI29hZHPSW/Rg=;
 b=kA0DAAoBNC0GU9GsrNsByyZiAGmwBcqh8d5mE3lAkbCCIhk2oWSgNcET++LXgLEGzX+74PInx
 YkBMwQAAQoAHRYhBDls8G2tYNRwNAKmmDQtBlPRrKzbBQJpsAXKAAoJEDQtBlPRrKzbYqsIAK5d
 elvBcseQjOmeiD4mSMAZLrcAEl20R9MpPKd4mWL5ml8BfXxNcML8Lnb2x/WwXL0Hqh2kmn+ol5+
 jwvmVgqFrje1/XM4onDIIomJOYl/rYSo9qoSx+5IKZAy9eiZAEDM2imcIQKtITZKLNjFZpUiemv
 mdOvazQvY2blxW+Lw4Oka7Gqf4ifxsINodUwI5EJjZnPs1AWGammHryjBSpAgbnOjEtCZ7iJAEM
 1l6rZhJZICWoWrt5P/y0CkrMmXMHjvK3or/XW/Oz6/UjFbEuZQMK4Nxx19avU2B1AgjKkKB7gjl
 xFjM+LS1mYwhLw6sC6tDl2dBVLvscyKlify3SXk=
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143722-1DCBBF5F-0E465A5B/0/0
X-purgate-type: clean
X-purgate-size: 10362
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 5121224C1D0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[avm.de,quarantine];
	R_DKIM_ALLOW(-0.20)[avm.de:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2580-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:amd-gfx@lists.freedesktop.org,m:apparmor@lists.ubuntu.com,m:bpf@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:cocci@inria.fr,m:dm-devel@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:gfs2@lists.linux.dev,m:intel-gfx@lists.freedesktop.org,m:intel-wired-lan@lists.osuosl.org,m:iommu@lists.linux.dev,m:kvm@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-block@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:linux-btrfs@vger.kernel.org,m:linux-cifs@vger.kernel.org,m:linux-clk@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-ext4@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-leds@vger.kernel.org,m:linux-media@vger.kernel.org,m:linux-mips@vger.kernel.org,m:linux-mm@kvack.org,m:linux-modules@vger.kernel.org,m:linux-mtd@lists.infradead.org,m:linux-nfs@vger.kernel.org,m:linux-omap@vger.kernel.org,m:linux-phy@l
 ists.infradead.org,m:linux-pm@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:linux-s390@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-sh@vger.kernel.org,m:linux-sound@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-trace-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:ntfs3@lists.linux.dev,m:samba-technical@lists.samba.org,m:sched-ext@lists.linux.dev,m:target-devel@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:v9fs@lists.linux.dev,m:phahn-oss@avm.de,m:Julia.Lawall@inria.fr,m:nicolas.palix@imag.fr,m:clm@fb.com,m:dsterba@suse.com,m:idryomov@gmail.com,m:amarkuze@redhat.com,m:slava@dubeyko.com,m:tytso@mit.edu,m:adilger.kernel@dilger.ca,m:sfrench@samba.org,m:pc@manguebit.org,m:ronniesahlberg@gmail.com,m:sprasad@microsoft.com,m:tom@talpey.com,m:bharathsm@microsoft.com,m:ericvh@kernel.org,m:lucho@ionkov.net,m:asmad
 eus@codewreck.org,m:linux_oss@crudebyte.com,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:miklos@szeredi.hu,m:almaz.alexandrovich@paragon-software.com,m:agruenba@redhat.com,m:kees@kernel.org,m:tony.luck@intel.com,m:gpiccoli@igalia.com,m:jack@suse.com,m:phillip@squashfs.org.uk,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:rostedt@goodmis.org,m:mhiramat@kernel.org,m:mathieu.desnoyers@efficios.com,m:tj@kernel.org,m:void@manifault.com,m:arighi@nvidia.com,m:changwoo@igalia.com,m:mingo@redhat.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[inria.fr,imag.fr,fb.com,suse.com,gmail.com,redhat.com,dubeyko.com,mit.edu,dilger.ca,samba.org,manguebit.org,microsoft.com,talpey.com,kernel.org,ionkov.net,codewreck.org,crudebyte.com,linux.alibaba.com,google.com,huawei.com,vivo.com,szeredi.hu,paragon-software.com,intel.com,igalia.com,squashfs.org.uk,zeniv.linux.org.uk,suse.cz,goodmis.org,efficios.com,manifault.com,nvidia.com,infradead.org,linaro.org,arm.com,suse.de,atomlin.com,samsung.com,perex.cz,canonical.com,paul-moore.com,namei.org,hallyn.com,linux-foundation.org,davemloft.net,holtmann.org,iogearbox.net,fomichev.me,mojatatu.com,resnulli.us,oracle.com,brown.name,sipsolutions.net,armlinux.org.uk,phrozen.org,alpha.franken.de,users.sourceforge.jp,libc.org,physik.fu-berlin.de,ideasonboard.com,kwiboo.se,linux.intel.com,ffwll.ch,ursulin.net,amd.com,rock-chips.com,sntech.de,marvell.com,lunn.ch,broadcom.com,chelsio.com,plvision.eu,foss.st.com,os.amperecomputing.com,bootlin.com,linux.ibm.com,ti.com,shazbot.org,animalcree
 k.com,nod.at,linuxfoundation.org,8bytes.org,coraid.com,kernel.dk,baylibre.com,pengutronix.de,alien8.de,zytor.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[phahn-oss@avm.de,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_GT_50(0.00)[248];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[avm.de:+];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo,avm.de:dkim,avm.de:email,avm.de:mid]
X-Rspamd-Action: no action

While doing some static code analysis I stumbled over a common pattern,
where IS_ERR() is combined with a NULL check. For that there is
IS_ERR_OR_NULL().

I've written a Coccinelle patch to find and patch those instances.
The patches follow grouped by subsystem.

Patches 55-58 may be dropped as they have a (minor?) semantic change:
They use WARN_ON() or WARN_ON_ONCE(), but only in the IS_ERR() path, not
for the NULL check. Iff it is okay to print the warning also for NULL,
then the patches can be applied.

While generating the patch set `checkpatch` complained about mixing
[un]likely() with IS_ERR_OR_NULL(), which already uses likely()
internally. I found and fixed several locations, where that combination
has been used.

Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
Philipp Hahn (61):
      Coccinelle: Prefer IS_ERR_OR_NULL over manual NULL check
      btrfs: Prefer IS_ERR_OR_NULL over manual NULL check
      ceph: Prefer IS_ERR_OR_NULL over manual NULL check
      ext4: Prefer IS_ERR_OR_NULL over manual NULL check
      smb: Prefer IS_ERR_OR_NULL over manual NULl check
      9p: Prefer IS_ERR_OR_NULL over manual NULL check
      erofs: Prefer IS_ERR_OR_NULL over manual NULL check
      fuse: Prefer IS_ERR_OR_NULL over manual NULL check
      ntfs3: Prefer IS_ERR_OR_NULL over manual NULL check
      gfs2: Prefer IS_ERR_OR_NULL over manual NULL check
      pstore: Prefer IS_ERR_OR_NULL over manual NULL check
      quota: Prefer IS_ERR_OR_NULL over manual NULL check
      squashfs: Prefer IS_ERR_OR_NULL over manual NULL check
      seq_file: Prefer IS_ERR_OR_NULL over manual NULL check
      trace: Prefer IS_ERR_OR_NULL over manual NULL check
      sched: Prefer IS_ERR_OR_NULL over manual NULL check
      module: Prefer IS_ERR_OR_NULL over manual NULL check
      sound: Prefer IS_ERR_OR_NULL over manual NULL check
      kvm: Prefer IS_ERR_OR_NULL over manual NULL check
      apparmor: Prefer IS_ERR_OR_NULL over manual NULL check
      lib/test: Prefer IS_ERR_OR_NULL over manual NULL check
      md: Prefer IS_ERR_OR_NULL over manual NULL check
      net/ipv6: Prefer IS_ERR_OR_NULL over manual NULL check
      net/9p: Prefer IS_ERR_OR_NULL over manual NULL check
      net/bluetooth: Prefer IS_ERR_OR_NULL over manual NULL check
      net/core: Prefer IS_ERR_OR_NULL over manual NULL check
      net/netlink: Prefer IS_ERR_OR_NULL over manual NULL check
      net/sched: Prefer IS_ERR_OR_NULL over manual NULL check
      net/sctp: Prefer IS_ERR_OR_NULL over manual NULL check
      net/sunrpc: Prefer IS_ERR_OR_NULL over manual NULL check
      net/tipc: Prefer IS_ERR_OR_NULL over manual NULL check
      net/wireless: Prefer IS_ERR_OR_NULL over manual NULL check
      mm: Prefer IS_ERR_OR_NULL over manual NULL check
      arch/arm: Prefer IS_ERR_OR_NULL over manual NULL check
      arch/mips: Prefer IS_ERR_OR_NULL over manual NULL check
      arch/sh: Prefer IS_ERR_OR_NULL over manual NULL check
      drm: Prefer IS_ERR_OR_NULL over manual NULL check
      net: Prefer IS_ERR_OR_NULL over manual NULL check
      irqchip: Prefer IS_ERR_OR_NULL over manual NULL check
      phy: Prefer IS_ERR_OR_NULL over manual NULL check
      pinctrl: Prefer IS_ERR_OR_NULL over manual NULL check
      pmdomain: Prefer IS_ERR_OR_NULL over manual NULL check
      s390: Prefer IS_ERR_OR_NULL over manual NULL check
      target: Prefer IS_ERR_OR_NULL over manual NULL check
      thermal: Prefer IS_ERR_OR_NULL over manual NULL check
      vfio: Prefer IS_ERR_OR_NULL over manual NULL check
      nfc: Prefer IS_ERR_OR_NULL over manual NULL check
      mtd: Prefer IS_ERR_OR_NULL over manual NULL check
      media: Prefer IS_ERR_OR_NULL over manual NULL check
      iommu: Prefer IS_ERR_OR_NULL over manual NULL check
      leds: Prefer IS_ERR_OR_NULL over manual NULL check
      gpib: Prefer IS_ERR_OR_NULL over manual NULL check
      hyperv: Prefer IS_ERR_OR_NULL over manual NULL check
      aoe: Prefer IS_ERR_OR_NULL over manual NULL check
      interconnect: Prefer IS_ERR_OR_NULL over manual NULL check
      clk: Prefer IS_ERR_OR_NULL over manual NULL check
      reset: Prefer IS_ERR_OR_NULL over manual NULL check
      arch/x86: Prefer IS_ERR_OR_NULL over manual NULL check
      debugobjects: Drop likely() around !IS_ERR_OR_NULL()
      Input alps: Drop unlikely() around IS_ERR_OR_NULL()
      file: Drop unlikely() around IS_ERR_OR_NULL()

 arch/arm/common/bL_switcher.c                      |   2 +-
 arch/mips/lantiq/clk.c                             |   2 +-
 arch/sh/mm/ioremap.c                               |   2 +-
 arch/x86/kernel/callthunks.c                       |   2 +-
 arch/x86/kernel/irq.c                              |   2 +-
 drivers/block/aoe/aoecmd.c                         |   2 +-
 drivers/clk/clk.c                                  |   4 +-
 drivers/clocksource/timer-pxa.c                    |   2 +-
 drivers/gpib/common/iblib.c                        |   2 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |   2 +-
 drivers/gpu/drm/drm_sysfs.c                        |   2 +-
 drivers/gpu/drm/i915/gvt/scheduler.c               |   4 +-
 drivers/gpu/drm/radeon/radeon_test.c               |   2 +-
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c    |   2 +-
 drivers/hv/mshv_eventfd.c                          |   4 +-
 drivers/input/mouse/alps.c                         |   2 +-
 drivers/interconnect/core.c                        |   2 +-
 drivers/iommu/omap-iommu.c                         |   2 +-
 drivers/irqchip/irq-gic-v3.c                       |   2 +-
 drivers/irqchip/irq-mvebu-odmi.c                   |   2 +-
 drivers/leds/trigger/ledtrig-tty.c                 |   2 +-
 drivers/md/dm-cache-metadata.c                     |   2 +-
 drivers/md/dm-crypt.c                              |   4 +-
 drivers/media/test-drivers/vimc/vimc-streamer.c    |   2 +-
 drivers/mtd/nand/raw/gpio.c                        |  10 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c   |   2 +-
 drivers/net/ethernet/broadcom/tg3.c                |   2 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c   |   3 +-
 drivers/net/ethernet/intel/ice/devlink/devlink.c   |   2 +-
 .../ethernet/marvell/prestera/prestera_router.c    |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   2 +-
 drivers/net/mdio/mdio-xgene.c                      |   2 +-
 drivers/net/usb/r8152.c                            |   2 +-
 drivers/nfc/trf7970a.c                             |   2 +-
 drivers/phy/phy-core.c                             |   2 +-
 drivers/pinctrl/core.c                             |   2 +-
 drivers/pmdomain/rockchip/pm-domains.c             |   2 +-
 drivers/reset/core.c                               |   2 +-
 drivers/s390/char/tape_class.c                     |   2 +-
 drivers/target/target_core_fabric_configfs.c       |   6 +-
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |   2 +-
 drivers/vfio/vfio_main.c                           |   2 +-
 fs/9p/fid.h                                        |   2 +-
 fs/btrfs/inode.c                                   |   2 +-
 fs/btrfs/transaction.c                             |   2 +-
 fs/btrfs/tree-log.c                                |   2 +-
 fs/btrfs/uuid-tree.c                               |   2 +-
 fs/ceph/dir.c                                      |   2 +-
 fs/ceph/snap.c                                     |   2 +-
 fs/erofs/zdata.c                                   |   2 +-
 fs/ext4/fast_commit.c                              |   2 +-
 fs/ext4/mballoc.c                                  |   2 +-
 fs/ext4/namei.c                                    |   2 +-
 fs/ext4/symlink.c                                  |   2 +-
 fs/fuse/dir.c                                      |   2 +-
 fs/gfs2/glock.c                                    |   2 +-
 fs/ntfs3/fsntfs.c                                  |   8 +-
 fs/pstore/zone.c                                   |   2 +-
 fs/quota/quota.c                                   |   2 +-
 fs/seq_file.c                                      |   4 +-
 fs/smb/client/cifsglob.h                           |   2 +-
 fs/smb/client/connect.c                            |   2 +-
 fs/smb/client/readdir.c                            |   2 +-
 fs/squashfs/cache.c                                |   2 +-
 include/linux/file.h                               |   2 +-
 include/net/9p/client.h                            |   2 +-
 kernel/module/main.c                               |   2 +-
 kernel/sched/ext.c                                 |   2 +-
 kernel/trace/fprobe.c                              |   2 +-
 kernel/trace/kprobe_event_gen_test.c               |   2 +-
 kernel/trace/trace_events_hist.c                   |   2 +-
 lib/debugobjects.c                                 |   2 +-
 lib/test_firmware.c                                |   2 +-
 lib/test_kmod.c                                    |   4 +-
 mm/kmemleak.c                                      |  16 +--
 net/9p/trans_rdma.c                                |   8 +-
 net/bluetooth/mgmt.c                               |   6 +-
 net/core/xdp.c                                     |   2 +-
 net/ipv6/ila/ila_xlat.c                            |   2 +-
 net/ipv6/ndisc.c                                   |   2 +-
 net/netlink/af_netlink.c                           |   2 +-
 net/sched/cls_api.c                                |   6 +-
 net/sctp/socket.c                                  |   2 +-
 net/sunrpc/xprtrdma/svc_rdma_transport.c           |  12 +-
 net/tipc/socket.c                                  |   2 +-
 net/wireless/reg.c                                 |   2 +-
 scripts/coccinelle/api/is_err_or_null.cocci        | 125 +++++++++++++++++++++
 security/apparmor/apparmorfs.c                     |   2 +-
 sound/soc/samsung/i2s.c                            |   4 +-
 sound/soc/xtensa/xtfpga-i2s.c                      |   2 +-
 virt/kvm/eventfd.c                                 |   4 +-
 91 files changed, 251 insertions(+), 127 deletions(-)
---
base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
change-id: 20260305-b4-is_err_or_null-59998a7d03c4

Best regards,
-- 
Philipp Hahn <phahn-oss@avm.de>


