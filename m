Return-Path: <linux-erofs+bounces-2632-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJLRAo0qsGlHgwIAu9opvQ
	(envelope-from <linux-erofs+bounces-2632-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Mar 2026 15:28:29 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 112A8251F4D
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Mar 2026 15:28:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVbpK169zz3bjb;
	Wed, 11 Mar 2026 01:28:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=18.9.28.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773152905;
	cv=none; b=cogAWP/se4zfX7Nu++Q5pyvHQovGQtbGVX7ZbU8cLsgP4DHouY89OQ9G/aUjCZ6ciFbZVn7iGzniTRGPaAgtZYqZrioFJmAy7fjHGzhqsPIkUbyfQaof3i7BnJEugc9rWJqDJv6hXEPmurYPlmU7mzkfoYCqB21KLwZGU1tTpwM/E6XkPmW2N0VJaFoqQ/yW/Os7FUSeIxkcBwUqt0oken1w54FTdE4nRRKzIwFeiFlVo8CH6hkrWyhE84N3FgOMtzx5Syz7lN/ww+vYI+hF92RN2xDK1vB5YO1WzcO5IRQKKOvMg3YoZdNcNHELw5GefwabjZq6qa3xkOwZZXiQLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773152905; c=relaxed/relaxed;
	bh=4/p8AtxdJ3b4aYgpRIBgOOPVM9R5HZLzlaxPPsEZ2Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7rapJqQwFdCMCgg9kiKkJjC9fN9pgUlkc2uWgIv+NvgAjmhOX3NAlrtBaYYymf8Ma/zFRhw+a8gcMTDyBbA8Ll4MRWcoIimZgr6mCMLXi2PzfKFUocUnb+OwvSHVFfAQaK2LtD/y/tGUjmz046vw+eXktqRF0G2gX2C1SXC8VJM6tqB/qV10kEn8trB6dtT9xl+iVBNyuSWk7D1w766hwww1/bIHFO7qkGd3JKKi4dcY4nrcglJF2N7V/vmPQAbSB+V1GANSeNAncMG4mtIHMV/kwfaUAX3YwcX7PI4ok9k/mYEONeWC+P5DNs4hi9taKPNos869zt0891pJ29qTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=mit.edu; dkim=pass (2048-bit key; unprotected) header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=LBScO8Ew; dkim-atps=neutral; spf=pass (client-ip=18.9.28.11; helo=outgoing.mit.edu; envelope-from=tytso@mit.edu; receiver=lists.ozlabs.org) smtp.mailfrom=mit.edu
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=LBScO8Ew;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mit.edu (client-ip=18.9.28.11; helo=outgoing.mit.edu; envelope-from=tytso@mit.edu; receiver=lists.ozlabs.org)
X-Greylist: delayed 156 seconds by postgrey-1.37 at boromir; Wed, 11 Mar 2026 01:28:22 AEDT
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVbpG66vGz30Lw
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Mar 2026 01:28:22 +1100 (AEDT)
Received: from macsyma.thunk.org (pool-173-48-117-133.bstnma.fios.verizon.net [173.48.117.133])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 62AENmJI023255
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 10:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1773152639; bh=4/p8AtxdJ3b4aYgpRIBgOOPVM9R5HZLzlaxPPsEZ2Q4=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=LBScO8Ewh5j+pvClPuvYJ6dYWu+6WL2ev3A6duJrcxObwFWjC8dgbq1R1jaNAuzD8
	 1N3QSZ+599jgS5LWqKIvONI9n0DrlV/bhIgTucL1f31tVRWGphyQLoG1P9ldyU2xAy
	 5HxclsvbqfBvFTqtCNAuPlMheXwVOKZyEuJ33r0JlgL4HScNylkzQj16H9ciOlXPZw
	 GOi/SKdKtyjuJFISqW7lcvm87iESFGZLsNPOvP7dH6Va+zkOTwCBsrnPVNMrNF7MaI
	 VGM4um3yd0mf+GQ4rfSGAnefCT4XC/KXug28EdqxTBjdSY5IyF4VkjDB0JxugqwdwX
	 rwveeKEi+qz0Q==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 96A8A5C4FCED; Tue, 10 Mar 2026 10:23:48 -0400 (EDT)
Date: Tue, 10 Mar 2026 10:23:48 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
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
        Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>,
        Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
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
        Sandeep Dhavale <dhavale@google.com>,
        Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
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
        Daniel Gomez <da.gomez@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Benjamin Marzinski <bmarzins@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Jon Maloy <jmaloy@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>, John Crispin <john@phrozen.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Zhenyu Wang <zhenyuw.linux@gmail.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Andy Yan <andy.yan@rock-chips.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Pavan Chebbi <pavan.chebbi@broadcom.com>,
        Michael Chan <mchan@broadcom.com>,
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
        Ulf Hansson <ulf.hansson@linaro.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Alex Williamson <alex@shazbot.org>,
        Mark Greer <mgreer@animalcreek.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>,
        Pavel Machek <pavel@kernel.org>, Dave Penkler <dpenkler@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
        Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>,
        Georgi Djakov <djakov@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 00/61] treewide: Use IS_ERR_OR_NULL over manual NULL
 check - refactor
Message-ID: <20260310142348.GA41218@macsyma-wired.lan>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 112A8251F4D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2632-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:phahn-oss@avm.de,m:amd-gfx@lists.freedesktop.org,m:apparmor@lists.ubuntu.com,m:bpf@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:cocci@inria.fr,m:dm-devel@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:gfs2@lists.linux.dev,m:intel-gfx@lists.freedesktop.org,m:intel-wired-lan@lists.osuosl.org,m:iommu@lists.linux.dev,m:kvm@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-block@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:linux-btrfs@vger.kernel.org,m:linux-cifs@vger.kernel.org,m:linux-clk@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-ext4@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-leds@vger.kernel.org,m:linux-media@vger.kernel.org,m:linux-mips@vger.kernel.org,m:linux-mm@kvack.org,m:linux-modules@vger.kernel.org,m:linux-mtd@lists.infradead.org,m:linux-nfs@vger.kernel.org,m:linux-omap@vger.kerne
 l.org,m:linux-phy@lists.infradead.org,m:linux-pm@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:linux-s390@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-sh@vger.kernel.org,m:linux-sound@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-trace-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:ntfs3@lists.linux.dev,m:samba-technical@lists.samba.org,m:sched-ext@lists.linux.dev,m:target-devel@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:v9fs@lists.linux.dev,m:Julia.Lawall@inria.fr,m:nicolas.palix@imag.fr,m:clm@fb.com,m:dsterba@suse.com,m:idryomov@gmail.com,m:amarkuze@redhat.com,m:slava@dubeyko.com,m:adilger.kernel@dilger.ca,m:sfrench@samba.org,m:pc@manguebit.org,m:ronniesahlberg@gmail.com,m:sprasad@microsoft.com,m:tom@talpey.com,m:bharathsm@microsoft.com,m:ericvh@kernel.org,m:lucho@ionkov.net,m:asmadeus@codewreck.or
 g,m:linux_oss@crudebyte.com,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:miklos@szeredi.hu,m:almaz.alexandrovich@paragon-software.com,m:agruenba@redhat.com,m:kees@kernel.org,m:tony.luck@intel.com,m:gpiccoli@igalia.com,m:jack@suse.com,m:phillip@squashfs.org.uk,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:rostedt@goodmis.org,m:mhiramat@kernel.org,m:mathieu.desnoyers@efficios.com,m:tj@kernel.org,m:void@manifault.com,m:arighi@nvidia.com,m:changwoo@igalia.com,m:mingo@redhat.com,m:peterz@infradead.org,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,lists.ubuntu.com,vger.kernel.org,inria.fr,lists.linux.dev,lists.osuosl.org,lists.infradead.org,lists.ozlabs.org,kvack.org,st-md-mailman.stormreply.com,lists.samba.org,lists.sourceforge.net,imag.fr,fb.com,suse.com,gmail.com,redhat.com,dubeyko.com,dilger.ca,samba.org,manguebit.org,microsoft.com,talpey.com,kernel.org,ionkov.net,codewreck.org,crudebyte.com,linux.alibaba.com,google.com,huawei.com,vivo.com,szeredi.hu,paragon-software.com,intel.com,igalia.com,squashfs.org.uk,zeniv.linux.org.uk,suse.cz,goodmis.org,efficios.com,manifault.com,nvidia.com,infradead.org,linaro.org,arm.com,suse.de,atomlin.com,samsung.com,perex.cz,canonical.com,paul-moore.com,namei.org,hallyn.com,linux-foundation.org,davemloft.net,holtmann.org,iogearbox.net,fomichev.me,mojatatu.com,resnulli.us,oracle.com,brown.name,sipsolutions.net,armlinux.org.uk,phrozen.org,alpha.franken.de,users.sourceforge.jp,libc.org,physik.fu-berlin.de,ideasonboard.com,kwiboo.se,linux.intel.com,ffwll.c
 h,ursulin.net,amd.com,rock-chips.com,sntech.de,marvell.com,lunn.ch,broadcom.com,chelsio.com,plvision.eu,foss.st.com,os.amperecomputing.com,bootlin.com,linux.ibm.com,ti.com,shazbot.org,animalcreek.com,nod.at,linuxfoundation.org,8bytes.org,coraid.com,kernel.dk,baylibre.com,pengutronix.de,alien8.de,zytor.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[tytso@mit.edu,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_GT_50(0.00)[247];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[mit.edu:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[macsyma-wired.lan:mid,lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 12:48:26PM +0100, Philipp Hahn wrote:
> While doing some static code analysis I stumbled over a common pattern,
> where IS_ERR() is combined with a NULL check. For that there is
> IS_ERR_OR_NULL().
> 
> I've written a Coccinelle patch to find and patch those instances.
> The patches follow grouped by subsystem.

I'm going to gently suggest that you *not* try to do this as a
tree-wide change, since we don't need to change some interface
requiring a global, flag day change.  This is instead a cleanup, which
maybe makes the code slightly better, but which also has a the
downside of breaking lots of inflight development patches by
potentially causing merge or patch conflicts.

So why don't you send it to each subsystem as a separate patch or
small patch series, instead of spamming a dozen-plus mailing lists,
are probably hundreds of developers, most of whom aren't going to
care about changs in some far flung part of the kernel?

Regards,

						- Ted

