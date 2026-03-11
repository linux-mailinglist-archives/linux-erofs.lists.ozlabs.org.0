Return-Path: <linux-erofs+bounces-2665-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ID7vJec0sWm0rwIAu9opvQ
	(envelope-from <linux-erofs+bounces-2665-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Mar 2026 10:24:55 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D35A3260531
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Mar 2026 10:24:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fW51c2JTKz3cND;
	Wed, 11 Mar 2026 20:24:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773221092;
	cv=fail; b=eWtHUao4vSIEP3ri+FpLfy/bpyiv0lDbBVUo3Wu3doPHc8kgAhsDw4NpjykJ1F6/7jLk6fWZXT8w1gt5gNY+qI588E8aUv35er7koJbFeGbg1nbScgf19VckWvB/aaTH7gWay3DjgUglnzg1/irhmyEryl8CrZJrIJICqw5JNzORIPJShbPj06Da/4fHE0+bUOzjWMH94k7Sb81phdWGSJRbzWR/KFdxF19j36LoUmYX7sj+0SLSWlHU0tSYR5T60sQdUguNuMeKLZTmtFkd838a9wGj+hiuDowjO+h4Qeg7S6w0S92qr/MGm4GTSiOz0JtNSK0lBX/PkMiWRIdvfQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773221092; c=relaxed/relaxed;
	bh=/WnYjaq9zqroKxNH1/RH2NWPVjerKMwSwnhWZn9wJdw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V1UXYDBjsN0AmxEnyKrZq2ffwCdqpDZRKkk8vhCNfebbSDBuMyAIp734L37ACmWNMZ2wMyPL+GA07evWr3h0ToPOzH4+BWpdgw8DZcVs6OIYT6xL3J3GI32pFhzxR03PS/cMUK1IzWKyibINzO0Q+es8AkiQVz/zY5xQGPeBHN5W8btkPbsnv4EbifsnaKmwwbhVpjeENw1h6EjbOfqqc04HhcKR4D8IM1E83QNg4lKze4AqBwW2404+wZ+fHGdhII1PzgNumFBiPR2HAeqX6NLad5VCgZTN6Fx+ZcKyeB5ltSbCepE6HWNmqIk89ywf3/TQtlTzS++Aaxtym3WrSQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RsYUZply; dkim-atps=neutral; spf=pass (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RsYUZply;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fW51Z71nJz3cMl
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Mar 2026 20:24:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773221091; x=1804757091;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/WnYjaq9zqroKxNH1/RH2NWPVjerKMwSwnhWZn9wJdw=;
  b=RsYUZply6Hp6uWOrPIcv7+drS8RfTSKdY9ZIeWyW4WjDOBI719kp4NSV
   VHlNr5JOLvFkvNVpZ1olmMAo5qm6uRPFQfVBEpSm5AO5+SLuhJ3S0Squf
   UmYj+Jv16DykzoRIjRduGUqATFx1xykJh9TsHA2P5V2JgziKQ0bjpr9eT
   tWKIKCyfcCMHWzCsVfk6H+ieLUIzm6XTFkO2gNKy8f4r87ZVYS+V8V2C1
   C4dqB//GX7UONRzQD1avT1gdTCA/MJpvuoTZ5VFL3sQF+/uYW1SUq9T4i
   UOaS48vBlk33Hptb6deGgkWSjhJSZj5Q5aG6zRQFJnkKnSBwhF2ss28Xd
   A==;
X-CSE-ConnectionGUID: d/l1LCClRMWs/hnYH2HNog==
X-CSE-MsgGUID: uFBLR9xATJ6LTWMyngHbSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="96899638"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="96899638"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:24:49 -0700
X-CSE-ConnectionGUID: +pNzCQuOS4iMOvUIOsAbbw==
X-CSE-MsgGUID: ihZy0IpkRxC1aXJmO8GjSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="220354338"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:24:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:24:48 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 02:24:48 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.3) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:24:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrGF6ysw3NLbFbz7lvDpDsZA34MAFk8M6PmU/DB+YGblIv+vOpJHUfRNdxOGGNT97eD/VPAXQl6832UdgZIlyco/xQ5N7yqkEP9715RZLzDgG2OCQPVM+c8qhUDQWzgNsSequTQ/0cGZBLotpTJdsw9XPPcvYJbc0W/0U13cjZxpsUs2+iBxSyLsO2jhJcZEEjEL65O/vlhdF4hOnb5V1YAhiiT08wChIxU/eWp8kLyw258X03oaDE2sw0J+vrdDo4X/jkMcyBQztWprdJH2K0PDhP9zDkx6cSSXKQUxpYrXJiioXIfZNZKg4X2+ZpjZTJceRSMn8YfckCdPx2uUBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WnYjaq9zqroKxNH1/RH2NWPVjerKMwSwnhWZn9wJdw=;
 b=fEMQ+ysMnPe2j7XVEXA7acz6fhMjQ0kXtpbPix/u4OCeSl+jsMwiaXRncu292Ubnorn0DFmHj2r5fbLBS0tMaktq3yLpK67Yz9MZZksKW8cMKWP2/48/oi0Qbs1/78nwAKQS7KbhAgoKszGdIsSEhsdgPE9oY5UL743qCUq3eDsvPGV3dDzXTaPgUrK8YyzNp3FSP4nEk8xs+4aJ3mC+Sh4E6VtTKOLz5Ii7TYM+65aXFKGenEDpdLjLIqzCmHlJv9WyB2CBoB7Psd0bEnvWvBHO4Wd/YCGFEyQWVmLhMz/4VAlbZ0SuEW9Ka72ut/ucLp+5aLw47WUReY3sBQQFuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH7PR11MB6836.namprd11.prod.outlook.com (2603:10b6:510:1ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Wed, 11 Mar
 2026 09:24:45 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 09:24:44 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Philipp Hahn <phahn-oss@avm.de>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>, "apparmor@lists.ubuntu.com"
	<apparmor@lists.ubuntu.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "cocci@inria.fr"
	<cocci@inria.fr>, "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"gfs2@lists.linux.dev" <gfs2@lists.linux.dev>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-cifs@vger.kernel.org"
	<linux-cifs@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>, "linux-ext4@vger.kernel.org"
	<linux-ext4@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-leds@vger.kernel.org"
	<linux-leds@vger.kernel.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "linux-mips@vger.kernel.org"
	<linux-mips@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
	"linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, "linux-sh@vger.kernel.org"
	<linux-sh@vger.kernel.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "ntfs3@lists.linux.dev"
	<ntfs3@lists.linux.dev>, "samba-technical@lists.samba.org"
	<samba-technical@lists.samba.org>, "sched-ext@lists.linux.dev"
	<sched-ext@lists.linux.dev>, "target-devel@vger.kernel.org"
	<target-devel@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "v9fs@lists.linux.dev"
	<v9fs@lists.linux.dev>
CC: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@kernel.org>, "Andrew
 Lunn" <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: RE: [Intel-wired-lan] [PATCH 39/61] irqchip: Prefer IS_ERR_OR_NULL
 over manual NULL check
Thread-Topic: [Intel-wired-lan] [PATCH 39/61] irqchip: Prefer IS_ERR_OR_NULL
 over manual NULL check
Thread-Index: AQHcsKKg9oKg4QUhq0yGHO8ZtUkDV7WpEHiA
Date: Wed, 11 Mar 2026 09:24:44 +0000
Message-ID: <IA3PR11MB898641F143E155B8A8069936E547A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-39-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-39-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH7PR11MB6836:EE_
x-ms-office365-filtering-correlation-id: 16e59c4a-c185-4674-e460-08de7f500851
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|921020|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: LSUZ060yA0zdkbfhlg7l9aVdcvsKojcvgwO3ACL3uZZlR/qzeqERV2DVHgMJwbPfqhu267UPDQzRLLv7X3d5RlS0JuOXDVxA9cm+WkkbMcCMMheQlIRAxrIktgbdkZESGhzlWgTbxl3Y/2gbbusycFgS0wjI5+GRZk26YjYST+YF3Cf7sBqIA7aduza3XxbWyGcS8eF9T0W6BRyf+jBN1IZ6mJ32KyDEwAPdnPfUMlrC6tr31AmtIuls+sW7d/tUscX6/XESWrivRoE+PBho0thaAsRLRKrhOV8qU1PPKRjY2iir7g48IrNLqDT5DRAQ22iTqJdt8cGwK7uoPrGBJxj7AULdq2IvwrtQYg0czy/oFGIJdrjEQvGAtmcVTPGkXmGkbNgRdgWIkvoA1lDlUMS2gALwKxiZh5PaAoX0JATl8b1EIr/ePZ+RXmc7HRRcAyUJ5ox0P84CR6ikaSNaIp/RQ4sOh2bGTfYI0V7N0JrWkAeVpHuGwS3+iRzCtLtXVMUvpcaKx6LgNt188r1ZN8p6Z9Jk/GFeOvJMqGFFsPLMwq0PebF4kfJt1gig815Ylf75pPpjL7O1ZPprsvGkgvnNM0uthucVJu6SuavLnsBH1QDfOy2BvuUqNHav1UU2sT7fQim8hOf8teLWQRN0nYSPrHNTDWP0c0PT2XpNnKCcpTYwz/bMUzACKZyfACaLP3dQ7r/lBBVithoKBQjk7PboSYKfrJ57BzzWTh1xwFMIbeKazCXevxZqhONUzLz3eAC5P0eeaEgZOsJ2yvUmoXihSND0r6uoToI7OcCqnrmC56cOaRHUHi+Q5fLAMXSS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmxSbWQwaUx5d3JubkVjM2tDUXZmaTdpNVNzYmdmbGhTdGRURTRxUjZPTFRL?=
 =?utf-8?B?QXVIejBEOFpaU0pHRXorVHBNR0c1dVV3Q0xBU2huK2VyNXBITU5IZU5vbHlI?=
 =?utf-8?B?UzdwS1BYVFhUUE1qRCtlK3JGZHN0bW5mNWNTdTVrTmhkWUlKTXJ6ZWlzcVlw?=
 =?utf-8?B?ZFFDYjZLaWFTeXhOYTA3SXpwWGVHVmZNcWZsQkUwZjhRa3BwbzFqWEdSQXA5?=
 =?utf-8?B?SndrMStaUmg1dFExejJqckFtNDBIOURJclI3MmVLOC85MGpETlBYWXU1MmJn?=
 =?utf-8?B?UjNTM0VUNEVkeHB4NlI0MENVSDlsclloMytKcERNVDczWjMzZHZTRjJtQ1pP?=
 =?utf-8?B?WTYwMVRsWXNLeDR4MWJxR0tqcmQ5OW1OTms2QXhScFdLQkgwRllnU2hIZWNC?=
 =?utf-8?B?dkl2TTcxbWJlRVBrWHRxaldyamNaTFgxdUF1Y2x1VmNTcVBVZEZvL25Gd2tm?=
 =?utf-8?B?V1Eybi9KOVJKZHIveW1kMVNmeUNVa3NpeDd4VURsRkRnSUZUN3p1SXQ1anhK?=
 =?utf-8?B?eVdDTTRNUUg3czYvK0lzUGFQcENCUEt6bGl6MENEalJ3aDFGaWlRVzRUMnRX?=
 =?utf-8?B?MEV6NmRseUFpYTdHL3FqYW41VWc1S3BYZEtkSGxTUkdZNEhBTXkwSkRSWVhr?=
 =?utf-8?B?enJSZ3V3VmJTa2gyWTdFVkdtcGpoTEVBSHB3Z2pUeFZ2M2IySDhTUTN4djUz?=
 =?utf-8?B?NUtscEVXM2Z3bFY2RGp2cGdpTXh4TG0rZmhhVDNLbGcrMFJ3dlUwSzlGYTQz?=
 =?utf-8?B?NEVxenZ4Wmt3TGdDalhRdWxSaFVVUWNaZUN2UlFZTFhFU1BPTFZhYlM1eHIv?=
 =?utf-8?B?YnVNbFFSYkRFaUZBcXpodHhnWldmRkUzUDVvQjVSZUlIb3FmOGw3UUM0TEgx?=
 =?utf-8?B?MFh2RGEyVHg3OVFhSE53OFhLakxqOHV2cGpJeHJVSXlLQXJBZUV3SFlMcHR2?=
 =?utf-8?B?OHZ2cmdKaGRvMUMvZHlmdklZUktUbk1FUFdoQk5YVENHS1pVN0VPRWp0Z214?=
 =?utf-8?B?Z1RYOEpJcHB3aXRXZ3I0cllMVVpRUk5xWTdXNXdpL0p1NTlCQnA5N1FRWDJ3?=
 =?utf-8?B?cnJoZGhrdm9MSFF3d1VlTlJzOVE5V0srdW8yd1o5RWdyRk5FYml5dUU3RWxK?=
 =?utf-8?B?TllLMW1nNVdXRytaYk5JWlVkKzdwbGdTRDhQYTdOTVpPRTh0Q0xzdkRsTmFm?=
 =?utf-8?B?WkJVUzhuWUNhRmZZZllKdzNvVWQwT203RTQrcVFHb0RSRHY5R0k4MEZZOC9l?=
 =?utf-8?B?dGlVbDEyMXFMbmZkYjNvcDdaR0JXODhaZ1hhYktwRytrT3VlM3NGbEdoSlZl?=
 =?utf-8?B?a2c5amkxTWlYV1c3K0tneUt6b0h6MUVMN1l0SG1mQXlRYWJiQXlJcUpZSTZG?=
 =?utf-8?B?MkRHdld0SDhDZUJ6Z0RIQURaNTdCbkNQdDJLWWR4clZuODBFSWg1QlNNdTlF?=
 =?utf-8?B?VHE1aGlCb1BMR3pxeFN1bTFaTmpnOHZnY3R2RWtmeEg2cjc5blgyT1czdGJw?=
 =?utf-8?B?UVdFbVB3Z1JwYnV0b1NidDkvZHZUUGp2dzQ0Z3RJRFVQUytJL1Jyb00raU5z?=
 =?utf-8?B?Wnlya3pMSW85ei9lbFJPNWE5U29vc08xUTY2b0psWnlrS1JZYWxUM0JvU3pX?=
 =?utf-8?B?d1NNSzhpcVFqV3RBZFhlZEQ4ODJlL2VyY3JaQzFibWxXVFI3TzZlZFlYbHVU?=
 =?utf-8?B?ZXVVUFhvYkFHdnRtUDJpdmRUZHh3SnFyNDZNd2FHUS9QNnRlSjRQbUNGNmJZ?=
 =?utf-8?B?N3QwaGN5a0lPQXJ3UmtHQmdXdFRQcVlSN21GUy96UGViTlBlNnZ4ak50dktI?=
 =?utf-8?B?UzhNbEZkVmJVb1BBY2lYbHJqQ2E0eDZhL3kvMFpXajVjSjVKaFByUHp6R1VW?=
 =?utf-8?B?QU1CaC9jUzdGL1IvaGNSMW5vbytyQ1RDeFZSVm5zT2ZkRmNFekpEZ1hkWWpG?=
 =?utf-8?B?bUFDK0xkd3Fld2laTHcra0srNUJabTMzdmV2bFZZbit6UXIveVp4djVsYkw0?=
 =?utf-8?B?YUd0M3J3RXdmSkpVSzhFKzB5bGRnRkxNVmR5RGFjWDErWFdCa1h5anljc1Q4?=
 =?utf-8?B?dzFwWlNFYitCTitjSTl0dVFpeitZV3BjMTdpanFTaEVocTFrbU1nTHZrZ1NV?=
 =?utf-8?B?VjNZMEtjK3BWTld2cjlmSlBOSjV5cG1kRnNSNW9peUpLT1dQaVlJRU9tU2NB?=
 =?utf-8?B?Z2RzRmM5YW9LcnNPZ0hWd3M1cnNwRXNzOEJrOW9MZXF3Q3ZHRTU5TXFhTVJj?=
 =?utf-8?B?NUNoVWZ2bXB3MmZ5U0tNRER0ZEMxZUY2dElmZDN5Y2UySzJTczgrdVFUVFpt?=
 =?utf-8?B?YWgrRlljbFVJZWI2UGtjSWVJcnEyYitUQ1c0R2NMQW4rQzZNQXkzUU5yT3p3?=
 =?utf-8?Q?EvJdgRAwpMEvFYGk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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
X-Exchange-RoutingPolicyChecked: Zf8elrkojfQdHLplxPSo4yK9pOgnQPMMprHUKo82JkQvl86yNTT6u7FAqvRzYBNdLnuPysxlVmp8BstvFqQDqny1cWRhAcdoxkdIDAaCWkbh77LFjBUgp1P5ILvzqgKv76QMGIEOh1HCHFDMNpA6qp6fjlUNhGD4z0Xuil3d/pUjxQZg/3YpD7F/p0nRjF86T2yIY3G/pKQ7VqTDdvTi73RoDCb8vNdc6V/1zzPvjfuZV2K1E+0W4p1UNIHK0+vefUDENNd8FZMhHxLc8ThB/MIuhK32ckKHzwIfbK/qurKFCa8fafTrKq8nMw4io2MAQKvogLpLBhp4MU1Nvqflcw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e59c4a-c185-4674-e460-08de7f500851
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 09:24:44.6383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yzVMZJlgYUyNW1d1n7aK2gDj2On6Yp4tdJvWL75v0WwQK8k+SncwWDB0auqqFg+FHOhWsQ/6XA7hgcstAFc1oOtOHcR/GJGawyNNy64hpBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6836
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.4 required=3.0 tests=ARC_INVALID,ARC_SIGNED,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: D35A3260531
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.40 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2665-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:phahn-oss@avm.de,m:amd-gfx@lists.freedesktop.org,m:apparmor@lists.ubuntu.com,m:bpf@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:cocci@inria.fr,m:dm-devel@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:gfs2@lists.linux.dev,m:intel-gfx@lists.freedesktop.org,m:intel-wired-lan@lists.osuosl.org,m:iommu@lists.linux.dev,m:kvm@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-block@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:linux-btrfs@vger.kernel.org,m:linux-cifs@vger.kernel.org,m:linux-clk@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-ext4@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-leds@vger.kernel.org,m:linux-media@vger.kernel.org,m:linux-mips@vger.kernel.org,m:linux-mm@kvack.org,m:linux-modules@vger.kernel.org,m:linux-mtd@lists.infradead.org,m:linux-nfs@vger.kernel.org,m:linux-omap@vger.kerne
 l.org,m:linux-phy@lists.infradead.org,m:linux-pm@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:linux-s390@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-sh@vger.kernel.org,m:linux-sound@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-trace-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:ntfs3@lists.linux.dev,m:samba-technical@lists.samba.org,m:sched-ext@lists.linux.dev,m:target-devel@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:v9fs@lists.linux.dev,m:maz@kernel.org,m:tglx@kernel.org,m:andrew@lunn.ch,m:gregory.clement@bootlin.com,m:sebastian.hesselbarth@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aleksandr.loktionov@intel.com,linux-erofs@lists.ozlabs.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_GT_50(0.00)[59];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,bootlin.com,gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgUGhp
bGlwcCBIYWhuDQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDEwLCAyMDI2IDEyOjQ5IFBNDQo+IFRv
OiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgYXBwYXJtb3JAbGlzdHMudWJ1bnR1LmNv
bTsNCj4gYnBmQHZnZXIua2VybmVsLm9yZzsgY2VwaC1kZXZlbEB2Z2VyLmtlcm5lbC5vcmc7IGNv
Y2NpQGlucmlhLmZyOyBkbS0NCj4gZGV2ZWxAbGlzdHMubGludXguZGV2OyBkcmktZGV2ZWxAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnOw0KPiBnZnMyQGxpc3RzLmxpbnV4LmRldjsgaW50ZWwtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZzsgaW50ZWwtd2lyZWQtDQo+IGxhbkBsaXN0cy5vc3Vvc2wub3Jn
OyBpb21tdUBsaXN0cy5saW51eC5kZXY7IGt2bUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtYmxvY2tAdmdlci5rZXJuZWwub3Jn
Ow0KPiBsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnOyBsaW51eC1idHJmc0B2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LQ0KPiBjaWZzQHZnZXIua2VybmVsLm9yZzsgbGludXgtY2xrQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtDQo+IGVyb2ZzQGxpc3RzLm96bGFicy5vcmc7IGxpbnV4LWV4dDRA
dmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gZnNkZXZlbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWdwaW9Admdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gaHlwZXJ2QHZnZXIua2VybmVsLm9yZzsg
bGludXgtaW5wdXRAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtbGVkc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBtZWRpYUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LW1pcHNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7
DQo+IGxpbnV4LW1vZHVsZXNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tdGRAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgbGludXgtDQo+IG5mc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW9tYXBAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC0NCj4gcGh5QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LXBtQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtDQo+IHJvY2tjaGlwQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxp
bnV4LXMzOTBAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gc2NzaUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LXNjdHBAdmdlci5rZXJuZWwub3JnOyBsaW51eC1zZWN1cml0eS0NCj4gbW9kdWxlQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtc2hAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gc291bmRA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1zdG0zMkBzdC1tZC1tYWlsbWFuLnN0b3JtcmVwbHkuY29t
Ow0KPiBsaW51eC10cmFjZS1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC11c2JAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC0NCj4gd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdl
ci5rZXJuZWwub3JnOw0KPiBudGZzM0BsaXN0cy5saW51eC5kZXY7IHNhbWJhLXRlY2huaWNhbEBs
aXN0cy5zYW1iYS5vcmc7IHNjaGVkLQ0KPiBleHRAbGlzdHMubGludXguZGV2OyB0YXJnZXQtZGV2
ZWxAdmdlci5rZXJuZWwub3JnOyB0aXBjLQ0KPiBkaXNjdXNzaW9uQGxpc3RzLnNvdXJjZWZvcmdl
Lm5ldDsgdjlmc0BsaXN0cy5saW51eC5kZXY7IFBoaWxpcHAgSGFobg0KPiA8cGhhaG4tb3NzQGF2
bS5kZT4NCj4gQ2M6IE1hcmMgWnluZ2llciA8bWF6QGtlcm5lbC5vcmc+OyBUaG9tYXMgR2xlaXhu
ZXIgPHRnbHhAa2VybmVsLm9yZz47DQo+IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD47IEdy
ZWdvcnkgQ2xlbWVudA0KPiA8Z3JlZ29yeS5jbGVtZW50QGJvb3RsaW4uY29tPjsgU2ViYXN0aWFu
IEhlc3NlbGJhcnRoDQo+IDxzZWJhc3RpYW4uaGVzc2VsYmFydGhAZ21haWwuY29tPg0KPiBTdWJq
ZWN0OiBbSW50ZWwtd2lyZWQtbGFuXSBbUEFUQ0ggMzkvNjFdIGlycWNoaXA6IFByZWZlcg0KPiBJ
U19FUlJfT1JfTlVMTCBvdmVyIG1hbnVhbCBOVUxMIGNoZWNrDQo+IA0KPiBQcmVmZXIgdXNpbmcg
SVNfRVJSX09SX05VTEwoKSBvdmVyIHVzaW5nIElTX0VSUigpIGFuZCBhIG1hbnVhbCBOVUxMDQo+
IGNoZWNrLg0KPiANCj4gQ2hhbmdlIGdlbmVyYXRlZCB3aXRoIGNvY2NpbmVsbGUuDQo+IA0KPiBU
bzogTWFyYyBaeW5naWVyIDxtYXpAa2VybmVsLm9yZz4NCj4gVG86IFRob21hcyBHbGVpeG5lciA8
dGdseEBrZXJuZWwub3JnPg0KPiBUbzogQW5kcmV3IEx1bm4gPGFuZHJld0BsdW5uLmNoPg0KPiBU
bzogR3JlZ29yeSBDbGVtZW50IDxncmVnb3J5LmNsZW1lbnRAYm9vdGxpbi5jb20+DQo+IFRvOiBT
ZWJhc3RpYW4gSGVzc2VsYmFydGggPHNlYmFzdGlhbi5oZXNzZWxiYXJ0aEBnbWFpbC5jb20+DQo+
IENjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gQ2M6IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcCBIYWhuIDxwaGFo
bi1vc3NAYXZtLmRlPg0KPiAtLS0NCj4gIGRyaXZlcnMvaXJxY2hpcC9pcnEtZ2ljLXYzLmMgICAg
IHwgMiArLQ0KPiAgZHJpdmVycy9pcnFjaGlwL2lycS1tdmVidS1vZG1pLmMgfCAyICstDQo+ICAy
IGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2lycWNoaXAvaXJxLWdpYy12My5jIGIvZHJpdmVycy9pcnFjaGlw
L2lycS1naWMtDQo+IHYzLmMgaW5kZXgNCj4gMjBmMTNiNjg2YWIyMmZhZjcyMmRkMmIyNGZhZjk2
YWY2MzZhNGJiZC4uNmRjOTgyNzM1N2EyMWFlMDVkZDgzOGZiNzE3OA0KPiA3MWM3M2YzYzc1NjIg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaXJxY2hpcC9pcnEtZ2ljLXYzLmMNCj4gKysrIGIvZHJp
dmVycy9pcnFjaGlwL2lycS1naWMtdjMuYw0KPiBAQCAtMjI1Miw3ICsyMjUyLDcgQEAgc3RhdGlj
IGludCBfX2luaXQgZ2ljX29mX2luaXQoc3RydWN0IGRldmljZV9ub2RlDQo+ICpub2RlLCBzdHJ1
Y3QgZGV2aWNlX25vZGUgKnBhcmUNCj4gDQo+ICBvdXRfdW5tYXBfcmRpc3Q6DQo+ICAJZm9yIChp
ID0gMDsgaSA8IG5yX3JlZGlzdF9yZWdpb25zOyBpKyspDQo+IC0JCWlmIChyZGlzdF9yZWdzW2ld
LnJlZGlzdF9iYXNlICYmDQo+ICFJU19FUlIocmRpc3RfcmVnc1tpXS5yZWRpc3RfYmFzZSkpDQo+
ICsJCWlmICghSVNfRVJSX09SX05VTEwocmRpc3RfcmVnc1tpXS5yZWRpc3RfYmFzZSkpDQo+ICAJ
CQlpb3VubWFwKHJkaXN0X3JlZ3NbaV0ucmVkaXN0X2Jhc2UpOw0KPiAgCWtmcmVlKHJkaXN0X3Jl
Z3MpOw0KPiAgb3V0X3VubWFwX2Rpc3Q6DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lycWNoaXAv
aXJxLW12ZWJ1LW9kbWkuYyBiL2RyaXZlcnMvaXJxY2hpcC9pcnEtDQo+IG12ZWJ1LW9kbWkuYw0K
PiBpbmRleA0KPiBiOTlhYjlkY2MxNGIzYmE5ODI4NzZjZjU1MjU0OTlkMDJiYzFjOTk3Li45NGU3
ZWRhNDZlODE4MzNjZmUwNDc5YjZmYWJiDQo+IGE3MTViZjRlZjZiOCAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9pcnFjaGlwL2lycS1tdmVidS1vZG1pLmMNCj4gKysrIGIvZHJpdmVycy9pcnFjaGlw
L2lycS1tdmVidS1vZG1pLmMNCj4gQEAgLTIxNyw3ICsyMTcsNyBAQCBzdGF0aWMgaW50IF9faW5p
dCBtdmVidV9vZG1pX2luaXQoc3RydWN0DQo+IGRldmljZV9ub2RlICpub2RlLA0KPiAgCWZvciAo
aSA9IDA7IGkgPCBvZG1pc19jb3VudDsgaSsrKSB7DQo+ICAJCXN0cnVjdCBvZG1pX2RhdGEgKm9k
bWkgPSAmb2RtaXNbaV07DQo+IA0KPiAtCQlpZiAob2RtaS0+YmFzZSAmJiAhSVNfRVJSKG9kbWkt
PmJhc2UpKQ0KPiArCQlpZiAoIUlTX0VSUl9PUl9OVUxMKG9kbWktPmJhc2UpKQ0KPiAgCQkJaW91
bm1hcChvZG1pc1tpXS5iYXNlKTsNCj4gIAl9DQo+ICAJYml0bWFwX2ZyZWUob2RtaXNfYm0pOw0K
PiANCj4gLS0NCj4gMi40My4wDQoNClJldmlld2VkLWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92IDxh
bGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCg==

