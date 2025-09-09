Return-Path: <linux-erofs+bounces-994-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7C6B4A9C8
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Sep 2025 12:12:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cLflD6y6Dz3cYV;
	Tue,  9 Sep 2025 20:12:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=185.183.30.70 arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757412760;
	cv=pass; b=m48qufwLpuLkfo1MuTP/Y0QiM887RENjL7+LFOXHnyUUQdtS9/zLTPugjlV/mTOO587tKOTR4meFmTEgC5mVj29FyPWGc6ipOjDpiJBMAD9q1pDGfPj+hGYzi2yL+hDvlYaEZTw9euxvF+Nr2T0xLJ540VvHS/UvEeFjorP7MECp//10MZi87N/CGvaJOfYHxcxjAGvisBP1mpH/X+P2r3nit7tqOeuHLXX/z695iBWQFeL2e496Fi9Eai48jzo+BnCeCWXN9TUMscmlVhOzq1nKOYhlSrYbk76S66kZnT+fk83JhYERLufszF8Em+5NDoXUsvj2IwmLV+kbXsxB6w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757412760; c=relaxed/relaxed;
	bh=JABFzrngekGBl7W4Snq7E3F4zv9u36CL/3irU81xcPg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IZFxVXZHlKuyz5RN+cbD+rrS/RAhXDyRmJ/RkZv4wDyMZfSLlkcokylG+oYJwIvnXkILN4oMuqRCHivJWzrzRzpNnu+RWS9JeJrqVS1PmTqvxMW6dhzz79BZ6XGrQFCN98yt67hkSKN6LYfY/pJZBowxP5VmAzHlcHqomnuOsG0GJ7UE6GJToXr0b+5gIKqvHwK47TazpLvO6DV4Bim/wDHlJ29PTm1JQLW1VX5vE564dROlcCYg13BdxEt1NN0GK1+EySldZyuBuC/dsRQ/wA/7Enp8gQBk6KCmfGFYyqb6tozO7EQTAgpn6whYM0z01SuaNTeJCCevGav9o/jClA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com; dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=gYAY0UU0; dkim-atps=neutral; spf=pass (client-ip=185.183.30.70; helo=mx08-001d1705.pphosted.com; envelope-from=yuezhang.mo@sony.com; receiver=lists.ozlabs.org) smtp.mailfrom=sony.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=gYAY0UU0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sony.com (client-ip=185.183.30.70; helo=mx08-001d1705.pphosted.com; envelope-from=yuezhang.mo@sony.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 631 seconds by postgrey-1.37 at boromir; Tue, 09 Sep 2025 20:12:39 AEST
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cLflC67bjz3cYR
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Sep 2025 20:12:38 +1000 (AEST)
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5897Z4xp006886;
	Tue, 9 Sep 2025 10:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=JABFzrn
	gekGBl7W4Snq7E3F4zv9u36CL/3irU81xcPg=; b=gYAY0UU086g2+cLZJV30cMa
	I9QoStQI/WY1KBxMenUYFv7FPgw9fjcqfsguByXTfpy27Vwb/h7OQJF6UXk4+xOO
	wvGCF0JIFncT0eNGLsDpNmTyOyFJbIKPEuJaHlCjp5gRIUenR2edAHntjptsBsjO
	/LI9epDjQphpp+9R5e2QwRGbOxZ5EhrpqLerlYz9UyEoCYwPg/pOde4GGh24kGBW
	wLYb7uEFhRMqIXQbfixe63C/OxuwG+yC7jZxXAux1Zz/0GDGS2m9M8ETUHt4wYnH
	omN3EZuJSrB4eJhLr3E1+SGotI+gVqbfPe8TfJefCGybcBCC21LkvteaVVekHqA=
	=
Received: from typpr03cu001.outbound.protection.outlook.com (mail-japaneastazon11012020.outbound.protection.outlook.com [52.101.126.20])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 490dbrtf83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 10:01:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pb0o55AyGc9lppAL2QqgyDKwHyn4PFvlkciKxSHy7FnPMdTb0ve9tDAP485VyOBEmUhTahyXqeDD1fmzUhIoXPAeUUpPnRuu49OPGNYfCxR+JGSSlPu7OotgqFzeLm3jMccStz0HF2n9BFX0uG2S4W21GP+wNoc4zmopO+Z+KW2biIhKP7zkyjVgEDPUCxldMoal//u6ouvfqLOkIIh5v/+VLUt4c612d6VS6MTcakMes+qDm3JffYZZWSQurisGb1HkcpFQqtcQujRPYTsEJF6T/UBYRzvJiubmhU2hj+bE4PHg2Nou2gy6a3AHA34muIAQ8eV/Kf0jO9fqU3pnXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JABFzrngekGBl7W4Snq7E3F4zv9u36CL/3irU81xcPg=;
 b=b0/6tpMJAJJ+YL6rUZtexvJ5xU2nBQXKUQ0XDcw6dUlzz3Icg0o2dhF0PCofXzuabeoRATq9QboaXrdu1WVa5eBInzKAlr5XneETCd7oOy8rHcIlA1dQCvfRH5YW2/d6J7TcIlxi87KU0Dn/Pyv0lpU8W0zrFK+wNkCSygqxOKi3G4IPn9q/pXOJsnPlyxxeQ2jeHHxLnFFaGectAmVAZIo0ot9nYm3sFpGtxgOUlcqqt3zwEcaTvOojrOg3uU7ZJzmOArhdIGWtyLCZ3d/uokTTJymk0fB0BEnCCeHJanRFI7KoC3BkqHXbwKBcx4BMwcSY17keAfI0WRQBFFUQpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by OSQPR04MB7779.apcprd04.prod.outlook.com (2603:1096:604:27b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 10:01:52 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 10:01:52 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
        "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>
CC: "Friendy.Su@sony.com" <Friendy.Su@sony.com>,
        "Daniel.Palmer@sony.com"
	<Daniel.Palmer@sony.com>
Subject: Re: [PATCH v1] erofs-utils: fix memory leaks and allocation issue
Thread-Topic: [PATCH v1] erofs-utils: fix memory leaks and allocation issue
Thread-Index: AQHcITT/5yBPkaIQ9U6wTLK6ybrHb7SKc5YAgAAMIbQ=
Date: Tue, 9 Sep 2025 10:01:52 +0000
Message-ID:
 <PUZPR04MB6316D33745FEA0695A05078C810FA@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20250909025247.572442-2-Yuezhang.Mo@sony.com>
 <0f01805f-434c-4b7a-b6da-52efbbff2b87@linux.alibaba.com>
In-Reply-To: <0f01805f-434c-4b7a-b6da-52efbbff2b87@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|OSQPR04MB7779:EE_
x-ms-office365-filtering-correlation-id: 2df98973-0fa8-4fa6-8879-08ddef87e6a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?GDbX3N3+q2Bn5pJluF5jDz/QSIEv3BEW6NJrp4hgCda0j07ratRlqzxcbs?=
 =?iso-8859-1?Q?+QN00xMwUW4wrz54xvTTXUpoDfZ9aPd2jsNgOKspVotAaimpzDS7Tu/bzl?=
 =?iso-8859-1?Q?00wGly8GZhu1gfxQ6gymWKITZK+LgaBR76gHRUN0ooGxmtsqWc5FXDXS9I?=
 =?iso-8859-1?Q?GNDgpCloyW51iKK6xlLOHEKYPTy4SiJHTTBDU5FJiHirVmNFxCxdC/dd3n?=
 =?iso-8859-1?Q?pZBPvu/YV7O/Dz/hMDgX2pcc1M1YPyI/Xjn5LpQWSPxKL82ZXORD/jrlt0?=
 =?iso-8859-1?Q?HvxuKCEZ/Bul1GW765PD4tISfI/mkWQEQCxualW9x1wCFtMdUia0CFyVlz?=
 =?iso-8859-1?Q?aK5yjwEGR3FoVq6NU5RTCYeck44FeOlz1/updmj2AK86kojelgw9JngU+z?=
 =?iso-8859-1?Q?Rt6Bl1rV7XCtwdfWg8m0N5yOmCZFGFh7M2m2Bcukk6YmfWsOOK8yD/xuYf?=
 =?iso-8859-1?Q?ktEWxKoZNFSmktJB/aPvdoAbVR9DBMiWZJErGrH7WyAkGN4kFQfKWAUNdM?=
 =?iso-8859-1?Q?u4Fa718VpV9KBb/D2i9u96vRFYTXE7fYv0hVlJyeUS1EOaYbzJT2Sf4G9R?=
 =?iso-8859-1?Q?9aCobGOtQWszmjTE+sKEqiuMs2XLXx+SVhF5WEwdPJtKrEPVBgEZ06Z8Ci?=
 =?iso-8859-1?Q?JxnqbFyu0iGYEQKVbbi03ZlNseyM/apeuG7qqtd2Fzu+6lUP30GVU1XEF4?=
 =?iso-8859-1?Q?JJvzJkoFVLI44f1nSJFOpdy9KjynJl4sY7lZxBlTGsWXThh0BaVQOC2s7n?=
 =?iso-8859-1?Q?GGzDv6xl60SjvAZrny4jLUBzpW51hHaDAkJ3XEFgfuNQI135QDT9jqcnup?=
 =?iso-8859-1?Q?AuovwHWK0xc0Fz6vi1GEQ3wpAmzzeTt7bC28EKkBK0MBRPedcKcRGPc9GC?=
 =?iso-8859-1?Q?6/ca6P55av7uleLhzRiLyQ0LJbEfU/I0ZQET87lNreuUvyLzgqf6R6JtEf?=
 =?iso-8859-1?Q?L6H5zIdvPDfq0yM7XKDhPR3z+gsFDghJFbEN0B/KGdf6weuw/lnwKcAToa?=
 =?iso-8859-1?Q?SeOtcikB1s+Rwafn+e1Er6ITaB66A/+ypxvdjEPEqW+6JkfmLCmoBfxmx1?=
 =?iso-8859-1?Q?41hgvq7sNKv3UQXHNWqaGAG++5Dx8lcJQml50hDm9WgCAIe3CLfaZf3M5h?=
 =?iso-8859-1?Q?EkII/+bkXxnV4h4RRiCC+Pb423AKRRmZ5fWMm3HzXTu4xeU/E7UyBFOU37?=
 =?iso-8859-1?Q?Lv/Wwhyv77GNvyTChAEjJMsmhz+ixq4a4xnVXcuyDZKLIrODxo/9iH+xkD?=
 =?iso-8859-1?Q?wN3Xe1GSFuX9ZowUscFTbvibE0bO0YttQz02M/fBZE8Eht7V5xcpnkmMg/?=
 =?iso-8859-1?Q?GayVcNOlGfiyTzDG2d7rbjNK2l2JbCPCdjBLqArNJwUBcN1LV7tcYOQ4IT?=
 =?iso-8859-1?Q?gPyAMx3msXJ5xqZXRXpgVcq3RIHanVBBP2PHhlNCWhfm2UlVf5dH7Obyvi?=
 =?iso-8859-1?Q?rhGyr/HmFq5SBFLbTeN9r+KqrHDwxXhw8BJbeu/PL06lNioOtUy732i3Nc?=
 =?iso-8859-1?Q?Md3EQbqXQlZCxD7Ym5kZqEO8xCJR1lQ0wEdBdmQvbmvS9gE2IeIl3dNJh4?=
 =?iso-8859-1?Q?0+N4IqQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?OepNFq+0Ato1IcYcLCVhaei1vvOC+NklJRo0xaFROaQ0AvKgN2wkwjErr0?=
 =?iso-8859-1?Q?W/+ZT4s8zr3WA3/DXsg6BR0wKkj+c3EY+IxNBzNrHtgklmdMrwNlKUBp/8?=
 =?iso-8859-1?Q?26C+FQRuzlNMnLk1e030mltNfoAv3hfc8Yvs0vJxVGwQAA+mMXHU4jh5VC?=
 =?iso-8859-1?Q?LRezqkgnxvOZIDh4deKguNW1i3KJJZybKAoXmg/elTTIB78FMivxZfiOSz?=
 =?iso-8859-1?Q?vCALqJsxey3B/KIlDFa9eKimghsbewHotdZaU+qfonUT4NOrccjBVqcfKi?=
 =?iso-8859-1?Q?HplZaaVDkzgx60j9XBqGPhtu2sHMI0SkW02iAkOlQclf9ElbX4Zr+ogo0F?=
 =?iso-8859-1?Q?B3WNlLv6Sg0PyqhOMykFf+e4zY4wrUenHiFh42ek2uBw6vS2z6Uw/AJ7I1?=
 =?iso-8859-1?Q?LhBvFO0A/3K+WcAErVVkicj6E8FxQODTSd7k5CeM/JALMZvH3llSfjzfnF?=
 =?iso-8859-1?Q?FPgw/J+yJr0pkzxRT+zV8wOsJLderd5lI6AbwAx8R4LyucWZ0whZI5qQgd?=
 =?iso-8859-1?Q?nsHGgQzUZf2dSnk4csF0eV3cU8xgKBjkjVAd1Tr0tDvkqshg4wvHW+4F8v?=
 =?iso-8859-1?Q?EhdjPtL1E8ndVa3OyrKX2rS+TmJ/OBtIno0x9vdYSfmv9dTQveLO9ckZrD?=
 =?iso-8859-1?Q?iRW/k9HKSoPu06ODb0VCTYU+h5j23LgRFZ1aYVQY8A5Q3QQSB+qWVESze7?=
 =?iso-8859-1?Q?YpQR1/FX6/ysn9DWLzmWJsIyzvzokVQWVSwp6s9ZFctMVhXxi8LvOFYN/W?=
 =?iso-8859-1?Q?cwdzbB/OF5teD05uBhflIpMeTNh6qh1o+30BQhmn02ND4gh1Bepv4t7ipo?=
 =?iso-8859-1?Q?KExo+SIK1rwFwdfzHEL417LEQRTp9Xr5l54ta4CPLONc/+wTpS02ucmNj8?=
 =?iso-8859-1?Q?kttGd60kqg5ON9LMeS/3YPV/SqxePCqoSXBVJsfzyzFCYip8UKYz3/Nk0y?=
 =?iso-8859-1?Q?swktWB4/16rsOahrmMOMnCscPl61LnMtsRxR/yJ6bEmQ+3OWdGl15ZCdim?=
 =?iso-8859-1?Q?L5hMpOFV4HXyG9enBed9Dcv0vsy0I7Yia6mWaPf2v9zxawJ9JP6dnvZGNY?=
 =?iso-8859-1?Q?FVxV7GvnYKTEMkPr5NscfG9vKgwSF8Mls/HFHSWrs255aecwBbNh7Hjw9C?=
 =?iso-8859-1?Q?I+nZGGIyEK4RlgU21B70m0EJB6SUGEm9BvndTpPcNo7bsTfdA6OI+cHrSz?=
 =?iso-8859-1?Q?4MwMCCAukzHVRcTyMNTh3/zBPKS7ZJTJAVvOnXU5J4ucCYqtCW+irtZWFk?=
 =?iso-8859-1?Q?CN041LLrZZIzO/aMMBPd8Edmm1erhNAfZaXbeJ5ej9NLesi4kex0qNyXmt?=
 =?iso-8859-1?Q?57PYgCcwz32seSOsThYmDh8O0rRWY81SfFAIqh7kDXYLmOyBH1kNhVb0gi?=
 =?iso-8859-1?Q?NBRcYhmCdD91eYA0vh3dNzKdPZdk37JtdDI0I1rYypU9MdXjIuL+nXPZaa?=
 =?iso-8859-1?Q?UG4kHoxBXXO+OLA+Y2/1egkEhLnhJasQu5FTuL+LTueTaYGpu6pCuKFRz2?=
 =?iso-8859-1?Q?21PL6n6zQGfP1Uy6ysuRVdlLIo3AS/4PjTmNVo+GzxIfZkeSG7np7nHdpO?=
 =?iso-8859-1?Q?xKJi2AEelRNSQuLgXYJ1G0SNHkUXHbcAzq4eYEBgPzxEG9EmXNWoj2UtdS?=
 =?iso-8859-1?Q?fszpEtFacTZcm+B3aiS/eKUZ17MgdTPGD60igcpOKRsd/bybZL8rgkKTaX?=
 =?iso-8859-1?Q?TaDrhPVxuo+UVPPvKho=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dqxSV48CZBe2RJE76BcZwIP9n3BT4haAHKKG5zKR8YKzfswkSz8qhl2IWUhA99zzMxHYV90WIGfeQcQJvW5sredSVy4PguZVKz6G3GkYMZvcCvpBv3c7pN+IDEmjc4aCSns8U9uR1VKO7VxvTPRIhxFS/3ZynxHztTQOe07VrEPjK7zXSnaCuNJ7nKkML9X2Dc6zdjQhiexixTYJMoOS5CNLk4llBEGltJ4CLSNCB04r0Q/F/QNOnT612Mm2mU753P495kyUuOkhKOd96OG/lSc+B0vkb/YZvNADbaw7jgeFneipwj1xbnVSWxxuW/JfjP4QC7n7V+btNpo7mF3jHYVh2OEysJooBHHgDteA/gjZh1UAAAhSi2r1nJQlD5SYJT8wfBJns9jrQU/cZeTMUV7sTli9nHWVRVtLJcS+Mxj4lzIgkI117WpE7KitoCgOrWAFBa4F/TJF4o1QAbKQxEQulum25ChBDFhCiKcW+Hliv1DSlAbIx8oXk2MCIPctBKRJvM5XSp/TmHRTCk5rHYHvZ4bpmI7HwbLAUzzMfY8A+BgwNe5lHd0jsBfvIEChDcY8lW3uUL1Go+vb1vrGj826N+9pqhqmfDCoFmEV7xdTIg8IBfsS7iAuriDifGVN
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df98973-0fa8-4fa6-8879-08ddef87e6a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 10:01:52.5319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b2A18oKoP/F5YMJWI87963awcMD8cEQHiWF2FrhsxFJwKF7SJqk1K1RQvZrvKhAsVkhiYrxdH+mT2wJEy15jdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR04MB7779
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX/aXUB3fNRdRb hq5xTHz9LADjKFzO1ojztEBYtR2Ub4oBj99G4wBm48hemw2aPuAjfCOYRGwPSTdiTGvlY8j0T7E R/YWgP6yKFMHoS6TgcRWK8o1lnD+bBKrpNpryvnGsV3UNAHMzMJ3+0v11rHIkqCXyT5wfmwiKWc
 TOZ4ve1u9LPWKcGaofW547wYx/fNd68/48fR7wzUHNBSgk1q23ZFZOVeU0b/5mQkseK7+Mu23Vo Tq+EmiqydKKpIuAO24HMODBDY+Hg7vXrEIfLrOHJjnS/ikOJaLEakyLOPOiSaYbrzHBx8Iylwrg FZbVZUKOglQCNouOMOzPc0cCR5MQJAvzZsqrm3Y4L3wB9wvkQ/yPsDD2yYBTbN6IjgamgNKHnBS dOk7BbSn
X-Proofpoint-ORIG-GUID: an14tcHFyw-Lsss66StLNLhSZVkZZDy3
X-Authority-Analysis: v=2.4 cv=J/eq7BnS c=1 sm=1 tr=0 ts=68bffb17 cx=c_pps a=UWyk5+a1JXsQzCbzjc+Vwg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=yJojWOMRYYMA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=z6gsHLkEAAAA:8 a=W6lftR-U125iwXj92cUA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: an14tcHFyw-Lsss66StLNLhSZVkZZDy3
X-Sony-Outbound-GUID: an14tcHFyw-Lsss66StLNLhSZVkZZDy3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Spam-Status: No, score=-0.9 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 2025/9/9 15:26, Gao Xiang wrote:=0A=
> Hi Yuezhang,=0A=
>=0A=
> On 2025/9/9 10:52, Yuezhang Mo wrote:=0A=
> > This patch addresses 4 memory leaks and 1 allocation issue to=0A=
> > ensure proper cleanup and allocation:=0A=
> >=0A=
> > 1. Fixed memory leak by freeing sbi->zmgr in z_erofs_compress_exit().=
=0A=
> > 2. Fixed memory leak by freeing inode->chunkindexes in erofs_iput().=0A=
> > 3. Fixed incorrect allocation of chunk index array in=0A=
> >     erofs_rebuild_write_blob_index() to ensure correct array allocation=
=0A=
> >     and avoid out-of-bounds access.=0A=
> > 4. Fixed memory leak of struct erofs_blobchunk not being freed by=0A=
> >     calling erofs_blob_exit() in rebuild mode.=0A=
> > 5. Fix memory leak by calling erofs_put_super().=0A=
> >     In main(), erofs_read_superblock() is called only to get the block=
=0A=
> >     size. In erofs_mkfs_rebuild_load_trees(), erofs_read_superblock()=
=0A=
> >     is called again, causing sbi->devs to be overwritten without being=
=0A=
> >     released.=0A=
> >=0A=
> > Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=0A=
> > Reviewed-by: Friendy Su <friendy.su@sony.com>=0A=
> > Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>=0A=
>=0A=
> Thanks for your patch and sorry for a bit delay...=0A=
>=0A=
> > ---=0A=
> >   lib/compress.c | 2 ++=0A=
> >   lib/inode.c    | 3 +++=0A=
> >   lib/rebuild.c  | 2 +-=0A=
> >   mkfs/main.c    | 3 ++-=0A=
> >   4 files changed, 8 insertions(+), 2 deletions(-)=0A=
> >=0A=
> > diff --git a/lib/compress.c b/lib/compress.c=0A=
> > index 622a205..dd537ec 100644=0A=
> > --- a/lib/compress.c=0A=
> > +++ b/lib/compress.c=0A=
> > @@ -2171,5 +2171,7 @@ int z_erofs_compress_exit(struct erofs_sb_info *s=
bi)=0A=
> >               }=0A=
> >   #endif=0A=
> >       }=0A=
> > +=0A=
> > +     free(sbi->zmgr);=0A=
> >       return 0;=0A=
> >   }=0A=
> > diff --git a/lib/inode.c b/lib/inode.c=0A=
> > index 7ee6b3d..0882875 100644=0A=
> > --- a/lib/inode.c=0A=
> > +++ b/lib/inode.c=0A=
> > @@ -159,6 +159,9 @@ unsigned int erofs_iput(struct erofs_inode *inode)=
=0A=
> >       } else {=0A=
> >               free(inode->i_link);=0A=
> >       }=0A=
> > +=0A=
> > +     if (inode->chunkindexes)=0A=
> > +             free(inode->chunkindexes);=0A=
> =0A=
> For now, this needs a check=0A=
> =0A=
>         if (inode->datalayout =3D=3D EROFS_INODE_CHUNK_BASED)=0A=
>                 free(inode->chunkindexes);=0A=
>=0A=
> I admit it's not very clean, but otherwise it doesn't work=0A=
> since `chunkindexes` is in a union.=0A=
>=0A=
=0A=
Okay, I will change to this check.=0A=
=0A=
> >       free(inode);=0A=
> >       return 0;=0A=
> >   }=0A=
> > diff --git a/lib/rebuild.c b/lib/rebuild.c=0A=
> > index 0358567..18e5204 100644=0A=
> > --- a/lib/rebuild.c=0A=
> > +++ b/lib/rebuild.c=0A=
> > @@ -186,7 +186,7 @@ static int erofs_rebuild_write_blob_index(struct er=
ofs_sb_info *dst_sb,=0A=
> >=0A=
> >       unit =3D sizeof(struct erofs_inode_chunk_index);=0A=
> >       inode->extent_isize =3D count * unit;=0A=
> > -     idx =3D malloc(max(sizeof(*idx), sizeof(void *)));=0A=
> > +     idx =3D calloc(count, max(sizeof(*idx), sizeof(void *)));=0A=
> >       if (!idx)=0A=
> >               return -ENOMEM;=0A=
> >       inode->chunkindexes =3D idx;=0A=
> > diff --git a/mkfs/main.c b/mkfs/main.c=0A=
> > index 28588db..bcde787 100644=0A=
> > --- a/mkfs/main.c=0A=
> > +++ b/mkfs/main.c=0A=
> > @@ -1702,6 +1702,7 @@ int main(int argc, char **argv)=0A=
> >                       goto exit;=0A=
> >               }=0A=
> >               mkfs_blkszbits =3D src->blkszbits;=0A=
> > +             erofs_put_super(src);=0A=
> =0A=
> Do you really need to fix this now (considering `mkfs.erofs`=0A=
> will exit finally)?=0A=
=0A=
As you said, mkfs.erofs will exit finally, it won't affect users=0A=
without this fix.=0A=
=0A=
The main purpose of this patch is to fix the memory allocation=0A=
issue in erofs_rebuild_write_blob_index(). It will cause a=0A=
segmentation fault if there are deduplications(If there are few=0A=
files, no segmentation fault occurs, but the files will be=0A=
inaccessible.).=0A=
=0A=
>=0A=
> In priciple, I think it should be fixed with a reference and=0A=
> something similiar to the kernel fill_super.=0A=
>=0A=
> I'm not sure if you have more time to improve this anyway,=0A=
> but the current usage is not perfect on my side...=0A=
=0A=
The memory leak is caused by the erofs_sb_info of the first blob=0A=
device being initialized twice, how to fix with reference? I do not=0A=
get your point.=0A=

