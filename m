Return-Path: <linux-erofs+bounces-2669-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNg3L1g1sWm0rwIAu9opvQ
	(envelope-from <linux-erofs+bounces-2669-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Mar 2026 10:26:48 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 514192606D7
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Mar 2026 10:26:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fW53m5nbrz3cQ4;
	Wed, 11 Mar 2026 20:26:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=198.175.65.12
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773221204;
	cv=fail; b=ZssMd4v3V2rVeultVlme6dwUQlHcDmDsPKWzX0rQ11rCnNGdsDg8uPcB8s4nOQK6Phf6+r+Q1JDlYmIbBnR5SajkeTuyHHD2l6VWVaaTGLBRHnIyDnnaamaXfLu/XCOYX1UlGDnnDvFLbxmfyqSkMDPCuPt3f+MJrRsjDsSW0WF6E9azfOOiE/xUek858C6kIZwGK0vmyTBJapW5JKeF9bU0FWZUT445stQmbpWOBQviHFhMVTF3vbQnvBN0s6oqBVzWbLgYG8tGzRT1F5nvx5KQVakTC2Nwqpvx5MNhafsOI+0iBt6L28Mke1i6MkjFOa9IChGFo5mNX7MUQ6qRog==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773221204; c=relaxed/relaxed;
	bh=m4nrxJrptq9qjGF+s6HBpmfa9vqvfEDymQUIf7o+O44=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UtmGFqdfwbfvpOXsYA5uMoSiCF9cp9mdURu8oNrzH5bNcnNxPTTIkbCsIiPeWnRISvlTZh7r/2uOrSn95r+nxzBtpbv+32GB4gf89gbnFLhKv6SJOqC2OUZrh6wUkSXbEfRjB/NcEoEwlLAWihQCx4wg/OmE7AcJjbV5ST+mC/+Thaq4qmf4pv+TETyb3yD7ZyF+kvyBdYRK0ygpD+W0f0eHqui/q2R+uzVu92bfa2HjpYzSLNBRgop29zkTavKqvksVLnBqxlFoR1dbIp9LZyOF1XrkBZq0jC3yaliMPX2T+ak86FFMy3f5/+RhQo2K7p9vlZqOg3BuxCc/1NMklg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dEwU8q2I; dkim-atps=neutral; spf=pass (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dEwU8q2I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fW53l544Bz3cPH
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Mar 2026 20:26:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773221205; x=1804757205;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m4nrxJrptq9qjGF+s6HBpmfa9vqvfEDymQUIf7o+O44=;
  b=dEwU8q2IIZ10HnfRfePVFhaR44uFdVDuwyAYCfYynaeDrfkYYYGR7uWz
   ZmIcZqtM96kKpq0FIwBuuNXBjOV6cqYxdfx5Y07na59kmjVJhxnzicPwI
   /tbHWKteWKqRE2ooAeJ6z3uMXKnMMO96L7ur/B08JMfT2rhYAU1L28JCQ
   58zoxlBZaH7vthR2JeDtBDTD2pOTwO2kb1Y6WV0enOhYFukHvBlab0bmn
   B+iWO0DYRSDH6nJCo61XEQVy0TJbWJy/huQh9A5OaaCZkVvSC0kgDRQGO
   LTMr+SBgynMGeMy94dekn0kq/YGo8gMbTRVp+fLhsQzm541/vIjv4+1MZ
   w==;
X-CSE-ConnectionGUID: yaZC+TPMSYOTbJB14aiw7w==
X-CSE-MsgGUID: MhOZbckUTaaRCHgHnABX9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="85760873"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="85760873"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:26:42 -0700
X-CSE-ConnectionGUID: 0Mvc00UjTyaR49tMurlA5w==
X-CSE-MsgGUID: 6g3dkHLDRdOJkiETBGMAMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="225103701"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:26:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:26:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 02:26:40 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.2) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:26:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIUmwbqBuCkYAHr/gwuMT/vbVyoJqHWc0S7qGkZSE95vriQ1cF1TkGN+a1PULfHbuDyi5DzAqAQ/PNHLIftR7JWBOHqHHT+jY93nxY5ZTaryKln3OoABQnwzl4ngeCG392k2OZCcRE+72NiuMFZgNGV9NuZjzzgtAKJSUl8jY6DJFEy1qNBSO6tQzZgbmelQ97j6UITzZy/WF4mr3LqAeRRhIoK91Gf/AWW++ljiOXiNYHRS0xvC/qW3hLE7seWkIxqqC0ez1Gs6saFyjGmdUV0qDNucOah0DJC0PY+O1yBivIsQu9Rd0Je4acivVundufd1+gxOD6g6HHhdSMq7zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4nrxJrptq9qjGF+s6HBpmfa9vqvfEDymQUIf7o+O44=;
 b=aBxZmB6sbegqcdGoKmtlZAOcsGRPJoNprfagE+h604gJAqAH4K6+KucWi6/tq0TarS5X5ug6WwI+Si+VnXJZGApS0Hp/He0BJm3O4i23WnRjIVWfT9fxBljBNaC9feFMVULojEpaixsil7zHJjzk/0Ei5rAY1WtxxlD9gS77inUNlktnOneLWplQNQV5pzR1G/7mz7TJdxJYLzt+Mj/x0RU8p5JaYh9hVbgYF9ieJV6cDINYiTVfqLAr/y19QYfhTWGVROS2hV99XVvqL7Clf7EilkoyJs2OW80ipPvFVFHkn71YZyTAVFDtCuAtCu+i3Ictw5nF52YGMajqU7oSAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH7PR11MB6836.namprd11.prod.outlook.com (2603:10b6:510:1ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Wed, 11 Mar
 2026 09:26:37 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 09:26:37 +0000
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
CC: Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>
Subject: RE: [Intel-wired-lan] [PATCH 54/61] aoe: Prefer IS_ERR_OR_NULL over
 manual NULL check
Thread-Topic: [Intel-wired-lan] [PATCH 54/61] aoe: Prefer IS_ERR_OR_NULL over
 manual NULL check
Thread-Index: AQHcsKKXHKPQgNOZaE+8HrFfa/02l7WpEP8g
Date: Wed, 11 Mar 2026 09:26:37 +0000
Message-ID: <IA3PR11MB898643D5101D44C2BF0A8D7AE547A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-54-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-54-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH7PR11MB6836:EE_
x-ms-office365-filtering-correlation-id: 3b137b1f-021b-47d3-320e-08de7f504b55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|921020|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: o9Bm9SPj2ErETACCCJiV1KvRnwRIZWxKp+r2VpCYTLVSrVoOXKHBBMTgWhVUDs2sANIccdbYTu+T62K218GKzN/aip0x72lnux++4JYJqlvh/+DLcxp1aRL+nnl8drAmndk+uoEKXHbjsrmbxKSpxxtM0yAgWpm+ZH5fdEYrQDmjD+U4clF8ZOIY5tdrP8KIkZKPgKHDF2WIQQw3kM6Neq/s19XJeWxmLprxLY7WEQtHIOBisCCjbPmMtmC0XeWKtE2QvujQvu1eudnbidCG6Owrkwkt7IMubEScD7/tiO4a6J8CaXb0tAJspoNXvqrDgBUuAlK6Zij7190dQ21EDY6HvvYrMZdBFum7HkCJ9c9euTvZsC4ESkWBnQwF4/dMWbNVJfHpB8DflELVEpkeDQ3x8Owrq/PTdR3oVwE/JTiZsKFpMvcfjloKUoUgBGjl7cK2eIKjQt6wm7RK6bMDB/1ajwKu+THF+Tg7TIUaB4p7dgM/iryDIosZN5plS1kAqVRyOkEiLAsO6f8ZbiVin+ueU3v211dxC7q+ylCyK3oioWwnNTn0243NE68MUoYZWMHZ5epFt6wq4t7JkSduO6Do/5LSsY9ynWsZnf5QwMmxXVPHYAa35TzmlVv/VQNApQGohJL/bIxrZD1Yl5/NbczocEPnIKZvTZsiZ0x0q0VZUEhP0bHuYPfQD0hUytJsjfviNaEYaOdc2HXjOuGQN4ezE9KU9/LVQB7y+Fu6Rvw+ygYyNvS5uRaazOasfnSyLhp3xd9l9KeyWCukEDFSJ5ns4y3fpZSU1j74TOlT+U4sj+sWuJNFh3Tl8Qe+8c16
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmFhZFRwZVJNNEZKWmhMbFo0K2FpUGZKZjZBa0M1RUJDemJkaitZUUlsWVNG?=
 =?utf-8?B?S2Z2VC9yVHNXcHkxeTdpMGk5OHZLbU1FQys1M0FUOXhkaFVVbWFXZ1doMHlI?=
 =?utf-8?B?SHlqWktRTnBBdzJkZVQ2R21OZ29iNk9mN3pMVjRaZStuZWY0TE53VmZ4Y3A4?=
 =?utf-8?B?TEJ1N09FbFp2WllBZUcrOEVSSHdVN1FQZHQxVkREdnpxVEFMTTVMWmx6c2RC?=
 =?utf-8?B?dWlpNlZwRVRORlh6aGpUSUlnNGsvWGhmWGJDUzZLbUM4ZXpjQ2R4b1NTTlJj?=
 =?utf-8?B?VDNQdWt3THNiZFlYN1AwYS82S2dtRWFhb1BpZUZqZlhydDFab2VINm8rSTM2?=
 =?utf-8?B?djF0MlBqL0x6R0xJbEFoeWlIVG90WjV5VVBtU21oSnE5WjROQ2dyVlFvallu?=
 =?utf-8?B?YngxK09vMFdibjA3T00yaXJuOW5qMTBrRElDQmRJVWdWVytQOEh4a2dLVXZT?=
 =?utf-8?B?NzRISHd2bkZiQnp4N2pUVjRKS0tVSThxeEhPWU1keE5GQTJRZmlLcVl3Vm1x?=
 =?utf-8?B?aGo0R3dpeGo5Z29rNFhsZ1Y2OVdqWTNBYXFpcTh5K2lGZGtqM2pWclViUmEy?=
 =?utf-8?B?RlRZcXI1aFhlY2FIWCt5aFFGU0VQbXM4RmVvYkw5amp3VFlEdlI4WWRRTXdy?=
 =?utf-8?B?VlRrQ2ptWU9Ka2Nrd0xpUHlnR01VQ3cvQ2Q1ZjBhOS8xeENJaUw2R2ZTUzlu?=
 =?utf-8?B?cXlsRDVDL0tUZURUbDA1MnJsT0NYUUc0UUVpTTVSem9QSUpWeXJveHZNUG90?=
 =?utf-8?B?OWsxbEw3ZGJVbFYydUtDUGt4ZE5NZWpBbHFQNnF0RzNLSTdHYmNMQm1UUjJE?=
 =?utf-8?B?Zm14WFRlOVI2V0UyT2NLdnJURmdsNzJtTGt0T3pYOHdCVXo3VjRuTVJEOGpl?=
 =?utf-8?B?a3IwU1U2RXE0SG4vWG1RdmRwZnhFbzZUV0dLRXloQjUwSVJsZzNVam92T05L?=
 =?utf-8?B?ajE0amhwN2hnTzQ4MGRmVWxPcnN4b2ZKUjlTZSs5Y1RHdFovQm04V1ZiRkps?=
 =?utf-8?B?TmxDZXo1bmp0bjNsU25ZZjVwMWpSdS9lWjFtQ3dpQm1jcWJaVG1XV24yOUx5?=
 =?utf-8?B?V3ZxTmtDVVE4RVpyYjR0VngreGp3NUpmOWpFcHpmMnhkWGtCSnE2VUpYMmRp?=
 =?utf-8?B?Y3hGc0c1MkdhUXpIbzhQYTFjaEFNYy9MTzFqb00wbzlNN1JBZzNIMnVKZDZJ?=
 =?utf-8?B?WWhObjJtOU1hT2crV2dGU3U1UFl2K1dlTkpBZW15V1doSUU2bW9tK0NWV01C?=
 =?utf-8?B?N0pGTktIWWxuVjloQnRKdmFuekJxcGsyb3VrU1FINTduVC9IbllqSlNocVZN?=
 =?utf-8?B?eGZQWTdZNGdxelg0UFJSdi9LRjJ3ek9BVm1pem5VREtlMXB2QWQvQXJjRFYv?=
 =?utf-8?B?Y3VqR0VlR1JHeDNBY2NVSHJJUzVyOGZxU0VFbW9LMEF4UHJ3V2pnamRlblpv?=
 =?utf-8?B?VnBkcEdBcDRFeTBIc3hkaUg1ZFdORjdsTXh5SjFsckdibEF5eGtueXVHcW5r?=
 =?utf-8?B?NU5TT3BJL01rVTU3cXMwdmxRN3E2QU9KQjkwMHRFaURCRlR6cVV3N3puZ1o0?=
 =?utf-8?B?R1dKd0FmYjRHVitKMUMrNjY4N2RuTkRuamoxcGtCWUJCMmZkQkovODZZeWxk?=
 =?utf-8?B?WkZtRURoT3NYRDVFcEMzNEp1anIzcUdyWVV0UllXR2NYcXU2SWZvTkNKeVUw?=
 =?utf-8?B?Y2NuNkdhalN4eWEvVFFRS1RzUnIzTDdMM1BRMDZQdXNuRHFmd0I1YUF6OVd1?=
 =?utf-8?B?b0czL0hrMnRwNjg2K1cxL0RwZmozV1lCZUxxWnJJbjdzd2xiTDZiR3M4ZUk0?=
 =?utf-8?B?RkFFV25lZHN2S0JjVXpTbXBjeE0yeVZQN0o4RW5ncXhxcHR1blVWYjhQdTRo?=
 =?utf-8?B?aTgwWTE4aWI5MnRFUlJiYjZDU2U1YWpVdFR4ci9yOUJGMVB6MXMxSGp5dDkz?=
 =?utf-8?B?cERDamNzcS9adzh3WUJ2VGI5cmV4cW9Ma3kwZitISjhwRk93KzdBMWFWVEs1?=
 =?utf-8?B?MnBmdEpxUHNUaGRqVit4YVZvNFFVa20zNEJUVUFuT25IOUllWkhoREZOM1Ny?=
 =?utf-8?B?WEFEL0Q1c1lka0RFZmJVRFpJWjlENzM0N25Nek0xMVlmZ1Iza0Jua2JMWFVX?=
 =?utf-8?B?aXp6NC81UldQNHdLN0lZSXJXRHZob296U3JXb2RMc2grZmI3RmRGR2I0cUh4?=
 =?utf-8?B?MEE4TlpEK05FRzVodEs0bEtua0w5Z0k2ekFSV2ZndTc1YTRJcDUvY1lOSjVy?=
 =?utf-8?B?QVhZUTE0MXdPaXZKWVY1aHh0TEhmV2t2a3VUY3NsdVVkQ3RwazQrVlhRRGJn?=
 =?utf-8?B?enhjSkdsU01ZdHgxWmVQSTR2OGM2c2dQRHlhZkl4SElCZnptQXl6NHo3dCs0?=
 =?utf-8?Q?Yx2xsHvVHigxyfmA=3D?=
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
X-Exchange-RoutingPolicyChecked: CrOTZb1KRrluE8Hi1qKRD454X4/8qRXPxHi1cqFPQYNvr17f1fATBKuEHUjSG1O0/Hvh6RKs6WeVHUo5EpnlqFyKsFw7LDG/GIpH5YjjRev4xPkZtie/dfZhrv5YkbetTk+MjZ8Asj/daThWAC8Zllg6yxdewJSZ8D4dkiye9+vWa9ukZPFzKvY1+65tMcplIRZvV88n5ehhcwlbn4RZ96lty+38Kp5E+09w1hvWqFY/RAdQprsQK7Zd7WsIAk8a7rlWJL9k8IIDPNrS0kNlcvkQyr9F0pz+zR8rGkj80VM1Nm95YwTUKIV55FRluvP5VKCN51YLe7kXO0zjLjfgrA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b137b1f-021b-47d3-320e-08de7f504b55
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 09:26:37.1030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AxdWCRDv24cjq1vJ384aXrRsVpA5dEn9LMt6b7ZY4xpRPyA7+lzpYDvdn+c/fLlu4FAozNXPYwAhO263RnUUNdrC+EOY+Cy5UgkT++EsOPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6836
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.4 required=3.0 tests=ARC_INVALID,ARC_SIGNED,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 514192606D7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.40 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2669-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:phahn-oss@avm.de,m:amd-gfx@lists.freedesktop.org,m:apparmor@lists.ubuntu.com,m:bpf@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:cocci@inria.fr,m:dm-devel@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:gfs2@lists.linux.dev,m:intel-gfx@lists.freedesktop.org,m:intel-wired-lan@lists.osuosl.org,m:iommu@lists.linux.dev,m:kvm@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-block@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:linux-btrfs@vger.kernel.org,m:linux-cifs@vger.kernel.org,m:linux-clk@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-ext4@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-leds@vger.kernel.org,m:linux-media@vger.kernel.org,m:linux-mips@vger.kernel.org,m:linux-mm@kvack.org,m:linux-modules@vger.kernel.org,m:linux-mtd@lists.infradead.org,m:linux-nfs@vger.kernel.org,m:linux-omap@vger.kerne
 l.org,m:linux-phy@lists.infradead.org,m:linux-pm@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:linux-s390@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-sh@vger.kernel.org,m:linux-sound@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-trace-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:ntfs3@lists.linux.dev,m:samba-technical@lists.samba.org,m:sched-ext@lists.linux.dev,m:target-devel@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:v9fs@lists.linux.dev,m:justin@coraid.com,m:axboe@kernel.dk,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aleksandr.loktionov@intel.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[56];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
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
bS5kZT4NCj4gQ2M6IEp1c3RpbiBTYW5kZXJzIDxqdXN0aW5AY29yYWlkLmNvbT47IEplbnMgQXhi
b2UgPGF4Ym9lQGtlcm5lbC5kaz4NCj4gU3ViamVjdDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENI
IDU0LzYxXSBhb2U6IFByZWZlciBJU19FUlJfT1JfTlVMTA0KPiBvdmVyIG1hbnVhbCBOVUxMIGNo
ZWNrDQo+IA0KPiBQcmVmZXIgdXNpbmcgSVNfRVJSX09SX05VTEwoKSBvdmVyIHVzaW5nIElTX0VS
UigpIGFuZCBhIG1hbnVhbCBOVUxMDQo+IGNoZWNrLg0KPiANCj4gQ2hhbmdlIGdlbmVyYXRlZCB3
aXRoIGNvY2NpbmVsbGUuDQo+IA0KPiBUbzogSnVzdGluIFNhbmRlcnMgPGp1c3RpbkBjb3JhaWQu
Y29tPg0KPiBUbzogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPg0KPiBDYzogbGludXgtYmxv
Y2tAdmdlci5rZXJuZWwub3JnDQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHAgSGFobiA8cGhhaG4tb3NzQGF2bS5kZT4NCj4gLS0tDQo+
ICBkcml2ZXJzL2Jsb2NrL2FvZS9hb2VjbWQuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
YmxvY2svYW9lL2FvZWNtZC5jIGIvZHJpdmVycy9ibG9jay9hb2UvYW9lY21kLmMNCj4gaW5kZXgN
Cj4gYTQ3NDRhMzBhOGFmNGZmMDUxMTNmMzIzNDAyMWVlYzcyODI2NWI0Zi4uYjMxZTUzOWE2NjQz
M2EwYTVkNmU4MTExN2EzMg0KPiBkMTI3MzVmZmMxYmMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
YmxvY2svYW9lL2FvZWNtZC5jDQo+ICsrKyBiL2RyaXZlcnMvYmxvY2svYW9lL2FvZWNtZC5jDQo+
IEBAIC0xMjY4LDcgKzEyNjgsNyBAQCBhb2Vfa3RzdGFydChzdHJ1Y3Qga3RzdGF0ZSAqaykNCj4g
DQo+ICAJaW5pdF9jb21wbGV0aW9uKCZrLT5yZW5kZXopOw0KPiAgCXRhc2sgPSBrdGhyZWFkX3J1
bihrdGhyZWFkLCBrLCAiJXMiLCBrLT5uYW1lKTsNCj4gLQlpZiAodGFzayA9PSBOVUxMIHx8IElT
X0VSUih0YXNrKSkNCj4gKwlpZiAoSVNfRVJSX09SX05VTEwodGFzaykpDQo+ICAJCXJldHVybiAt
RU5PTUVNOw0KPiAgCWstPnRhc2sgPSB0YXNrOw0KPiAgCXdhaXRfZm9yX2NvbXBsZXRpb24oJmst
PnJlbmRleik7IC8qIGFsbG93IGt0aHJlYWQgdG8gc3RhcnQgKi8NCj4gDQo+IC0tDQo+IDIuNDMu
MA0KDQpSZXZpZXdlZC1ieTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25v
dkBpbnRlbC5jb20+DQo=

